--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 13
--

USE master;
GO
-- Enable snapshot isolation for the database, if desired
ALTER DATABASE WideWorldImporters
    SET ALLOW_SNAPSHOT_ISOLATION ON;
-- Enable change tracking for the database
ALTER DATABASE WideWorldImporters
    SET CHANGE_TRACKING = ON
    (CHANGE_RETENTION = 5 DAYS, AUTO_CLEANUP = ON);

USE WideWorldImporters_modded;
GO
-- Enable change tracking for Orders
ALTER TABLE Sales.Orders
    ENABLE CHANGE_TRACKING
    -- and track which columns were included in the statements
WITH (TRACK_COLUMNS_UPDATED = ON);
-- Enable change tracking for OrderLines
ALTER TABLE Sales.OrderLines
    ENABLE CHANGE_TRACKING;
-- Disable change tracking for OrderLines
ALTER TABLE Sales.OrderLines
    DISABLE CHANGE_TRACKING;

-- Query the current state of change tracking in the database
SELECT *
FROM sys.change_tracking_tables;

-- CHANGE DATA CAPTURE
USE WideWorldImporters;
GO
EXEC sys.sp_cdc_enable_db;
EXEC sys.sp_cdc_enable_table
    @source_schema = ‘Sales’,
    @source_name = ‘Invoices’,
    @role_name = ‘cdc_reader’;

/* TESTING IT ALL OUT */

-- Modify a row in the Orders table,
-- which has change tracking enabled
UPDATE Sales.Orders
    SET Comments = ‘I am a new comment!’
    WHERE OrderID = 1;

-- Query all changes
DECLARE @OrderCommentsColumnId int =
    COLUMNPROPERTY(OBJECT_ID(‘Sales.Orders’), N’Comments’, ‘ColumnId’),
    @DeliveryInstructionsColumnId int =
    COLUMNPROPERTY(OBJECT_ID(‘Sales.Orders’), N’DeliveryInstructions’, ‘ColumnId’);
-- Query all changes to Sales.Orders
SELECT *
    -- Determine if the Comments column was included in the UPDATE
    , CHANGE_TRACKING_IS_COLUMN_IN_MASK(@OrderCommentsColumnId,
        CT.SYS_CHANGE_COLUMNS) CommentsChanged
    -- Determine if the DeliveryInstructions column was included
    , CHANGE_TRACKING_IS_COLUMN_IN_MASK(@DeliveryInstructionsColumnId,
        CT.SYS_CHANGE_COLUMNS) DeliveryInstructionsChanged
FROM CHANGETABLE(CHANGES Sales.Orders, 0) as CT
ORDER BY SYS_CHANGE_VERSION;

-- Modify a row in the Invoices table,
-- which has change data capture enabled
UPDATE Sales.Invoices
    SET Comments = ‘I am a new invoice comment again’
    WHERE InvoiceID = 1;

DECLARE @from_lsn binary(10) = sys.fn_cdc_get_min_lsn(‘Sales_Invoices’),
    @to_lsn binary(10) = sys.fn_cdc_get_max_lsn();

-- Each capture instance will have unique function names
-- By default, the capture instance name is schema_table
-- Note: there may be a slight delay before output is returned
SELECT *
FROM cdc.fn_cdc_get_all_changes_Sales_Invoices(@from_lsn, @to_lsn,
    N’all update old’);

-- Cleanup
EXEC sys.sp_cdc_disable_table
	@source_schema = 'Sales',
	@source_name = 'Invoices',
	-- Not explicitly defined in the _enable_ call, thus default
	@capture_instance = 'Sales_Invoices';
EXEC sys.sp_cdc_disable_db;
