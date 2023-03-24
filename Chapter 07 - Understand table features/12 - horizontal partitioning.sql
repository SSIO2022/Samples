--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 12
--
/*
	DATABASE HAS
	- 3 FILEGROUPS: PRIMARY, FILEGROUP2, FILEGROUP3
*/

USE master;
GO

-- Replace 'C:\SQLData\Data\' with your data file path
CREATE DATABASE HorizPart
	-- Primary filegroup, for non-partitioned data
    ON        PRIMARY      (NAME = 'NonPart', FILENAME = 'C:\SQLData\Data\HorizPart.mdf'), 
	-- 3 filegroups for partitioned data
    FILEGROUP FILEGROUP2 (NAME = 'HorizPart1', FILENAME = 'C:\SQLData\Data\HorizPart1.ndf'), 
    FILEGROUP FILEGROUP3 (NAME = 'HorizPart2', FILENAME = 'C:\SQLData\Data\HorizPart2.ndf'),
    FILEGROUP FILEGROUP4 (NAME = 'HorizPart3', FILENAME = 'C:\SQLData\Data\HorizPart3.ndf')
	-- Log file
    LOG ON               (NAME = 'HorizPart_log', FILENAME = 'C:\SQLData\Data\HorizPart.ldf');
GO

USE HorizPart;
GO

/*
	SET UP PARTITIONING
*/
-- Create a partition function for February 1, 2019 through January 1, 2020
CREATE PARTITION FUNCTION MonthPartitioningFx (datetime2)
    -- Store the boundary values in the right partition
    AS RANGE RIGHT
   -- Each month is defined by its first day (the boundary value)
    FOR VALUES ('20190201', '20190301', '20190401',
      '20190501', '20190601', '20190701', '20190801',
      '20190901', '20191001', '20191101', '20191201', '20200101');
      
-- Create a partition scheme using the partition function
-- Place each trimester on its own partition
-- The most recent of the 13 months goes in the latest partition
CREATE PARTITION SCHEME MonthPartitioningScheme
    AS PARTITION MonthPartitioningFx
    TO (FILEGROUP2, FILEGROUP2, FILEGROUP2, FILEGROUP2,
        FILEGROUP3, FILEGROUP3, FILEGROUP3, FILEGROUP3,
        FILEGROUP4, FILEGROUP4, FILEGROUP4, FILEGROUP4, FILEGROUP4);


-- Create a partitioned table
CREATE TABLE dbo.Transactions (
	TransactionId		int NOT NULL IDENTITY(1,1),
	TransactionTimeUtc	datetime2 NOT NULL 
		CONSTRAINT DF_TransactionTime DEFAULT SYSUTCDATETIME(),
	-- Omitting additional common columns for brevity

	-- TransactionTimeUtc must be part of the primary key (unique index),
	-- because we're using the partition scheme here too
	CONSTRAINT PK_Transactions PRIMARY KEY NONCLUSTERED (TransactionId, TransactionTimeUtc) 
		ON MonthPartitioningScheme (TransactionTimeUtc)
) ON MonthPartitioningScheme (TransactionTimeUtc);

-- Create an aligned clustered index (not the primary key, in this case)
CREATE CLUSTERED INDEX CX_Transactions
	ON dbo.Transactions(TransactionTimeUtc) 
	ON MonthPartitioningScheme (TransactionTimeUtc);

-- Insert two sample data rows.
-- Note the rows will be placed in different partitions and filegroups
INSERT INTO dbo.Transactions (TransactionTimeUtc) VALUES
('2019-06-01T03:04:05'),
('2019-10-01T08:09:10');

/* Verify partitions
 * You'll find 26 partitions, one for each index
 * Pay attention to the row_count column to determine
 * where the sample rows are stored
 */
DECLARE @TxTableObjectId int = OBJECT_ID('dbo.Transactions');

SELECT * 
FROM sys.dm_db_partition_stats
WHERE object_id = @TxTableObjectId;
SELECT * 
FROM sys.partitions
WHERE object_id = @TxTableObjectId;

-- Cleanup
USE master;
GO

DROP DATABASE HorizPart;
