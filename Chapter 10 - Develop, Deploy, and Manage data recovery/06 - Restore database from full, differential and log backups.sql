--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

-- First, restore the full backup
RESTORE DATABASE [WideWorldImporters]
FROM DISK = N'C:\SQLData\Backup\SERVER_WideWorldImporters_FULL_20220918_210912.BAK'
WITH MOVE N'WideWorldImporters' TO N'C:\SQLData\WWI.mdf'
    , MOVE N'WideWorldImporters_log' TO N'C:\SQLData\WWI.ldf'
    , NORECOVERY;
GO

-- Second, restore the most recent differential backup
RESTORE DATABASE [WideWorldImporters]
FROM DISK = N'C:\SQLData\Backup\SERVER_WideWorldImporters_DIFF_20220926_120100.BAK'
WITH NORECOVERY;
GO

-- Finally, restore all transaction log backups after the differential
RESTORE LOG [WideWorldImporters]
FROM DISK = N'C:\SQLData\Backup\SERVER_WideWorldImporters_LOG_20220926_121500.BAK'
WITH NORECOVERY;
GO

RESTORE LOG [WideWorldImporters]
FROM DISK = N'C:\SQLData\Backup\SERVER_WideWorldImporters_LOG_20220926_123000.BAK'
WITH NORECOVERY;
GO

-- Bring the database online
RESTORE LOG [WideWorldImporters]
WITH RECOVERY;
GO
