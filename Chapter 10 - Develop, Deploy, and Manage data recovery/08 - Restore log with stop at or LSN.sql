/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

/*  Restore point in time using timestamp */
RESTORE LOG [WideWorldImporters]
FROM DISK = N'C:\SQLData\Backup\SERVER_WideWorldImporters_LOG_20220926_123000.BAK'
WITH STOPAT = 'Sep 26, 2022 12:28 AM', RECOVERY;
GO

/*  Or restore point in time using LSN
    Assume that this LSN is where the bad thing happened */
RESTORE LOG [WideWorldImporters]
FROM DISK = N'C:\SQLData\Backup\SERVER_WideWorldImporters_LOG_20220926_123000.BAK'
WITH STOPBEFOREMARK = 'lsn:0x0000029f:00300212:0002', RECOVERY;
GO
