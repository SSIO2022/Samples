/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

SELECT SYSDATETIMEOFFSET() AS [Time_Observed]
	, CONVERT(DECIMAL(9, 1) 
		,100 * (
			SELECT CONVERT(DECIMAL(9, 1), [cntr_value]) AS [cntr_value]
			FROM [sys].[dm_os_performance_counters] AS [pc]
			WHERE [pc].[COUNTER_NAME] = 'Buffer cache hit ratio'
				AND [pc].[OBJECT_NAME] LIKE '%:Buffer Manager%'
			) / (
			SELECT CONVERT(DECIMAL(9, 1), [cntr_value]) AS [cntr_value]
			FROM [sys].[dm_os_performance_counters] AS [pc]
			WHERE [pc].[COUNTER_NAME] = 'Buffer cache hit ratio base'
				AND [pc].[OBJECT_NAME] LIKE '%:Buffer Manager%'
			)
		) AS [Buffer_Cache_Hit_Ratio];
