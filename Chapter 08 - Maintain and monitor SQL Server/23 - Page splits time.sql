/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

DECLARE @page_splits_Start_ms BIGINT
	, @page_splits_Start BIGINT
	, @page_splits_End_ms BIGINT
	, @page_splits_End BIGINT;

SELECT @page_splits_Start_ms = [ms_ticks]
	, @page_splits_Start = [cntr_value]
FROM [sys].[dm_os_sys_info]
	CROSS APPLY [sys].[dm_os_performance_counters]
WHERE [counter_name] = 'Page Splits/sec'
	AND [object_name] LIKE '%SQL%Access Methods%'; -- Find the object that contains page splits 

WAITFOR DELAY '00:00:05';--Duration between samples 5s 

SELECT @page_splits_End_ms = MAX([ms_ticks])
	, @page_splits_End = MAX([cntr_value])
FROM [sys].[dm_os_sys_info]
	CROSS APPLY [sys].[dm_os_performance_counters]
WHERE [counter_name] = 'Page Splits/sec'
	AND [object_name] LIKE '%SQL%Access Methods%'; -- Find the object that contains page splits 

SELECT SYSDATETIMEOFFSET() AS [Time_Observed]
	, CONVERT(DECIMAL(19, 3), (@page_splits_End - @page_splits_Start) * 1.0 / NULLIF(@page_splits_End_ms - @page_splits_Start_ms, 0)) AS Page_Splits_per_s;
