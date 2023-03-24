--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 9: AUTOMATE SQL SERVER ADMINISTRATION
-- T-SQL SAMPLE 7

DECLARE @object_name SYSNAME = CASE
		WHEN CHARINDEX('\', @@SERVERNAME) = 0
		THEN 'SQLServer'
		ELSE 'MSSQL$' + SUBSTRING(@@SERVERNAME, CHARINDEX('\', @@SERVERNAME) + 1, 100)
	END + ':Buffer Manager';

SELECT [BufferCacheHitRatio] = (bchr * 1.0 / bchrb) * 100.0
FROM (SELECT bchr = cntr_value
		FROM sys.dm_os_performance_counters
		WHERE counter_name = 'Buffer cache hit ratio'
			AND object_name = @object_name) AS r
CROSS APPLY (SELECT bchrb= cntr_value
		FROM sys.dm_os_performance_counters
		WHERE counter_name = 'Buffer cache hit ratio base'
			AND object_name = @object_name) AS rb;
