/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

SELECT SYSDATETIMEOFFSET() AS [Time_Observed]
	, MAX(CONVERT(DECIMAL(19, 3), [os].[physical_memory_kb] / 1024.0 / 1024.0)) AS [OS_Memory_GB]
	, MAX(CONVERT(DECIMAL(19, 3), [sm].[available_physical_memory_kb] / 1024.0 / 1024.0)) AS [OS_Available_Memory_GB]
	, MAX(CASE [counter_name]
			WHEN 'Target Server Memory (KB)' THEN 
				CONVERT(DECIMAL(19, 3), [cntr_value] / 1024.0 / 1024.0)
			END) AS [SQL_Target_Server_Mem_GB]
	, MAX(CASE [counter_name]
			WHEN 'Total Server Memory (KB)' THEN 
				CONVERT(DECIMAL(19, 3), [cntr_value] / 1024.0 / 1024.0)
			END) AS [SQL_Total_Server_Mem_GB]
	, MAX(CASE [counter_name]
			WHEN 'Page life expectancy' THEN 
				[cntr_value]
			END) AS [PLE_s]
FROM [sys].[dm_os_performance_counters] AS [pc]
	CROSS JOIN [sys].[dm_os_sys_info] AS [os]
	CROSS JOIN [sys].[dm_os_sys_memory] AS [sm];
