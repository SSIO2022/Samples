SELECT Time_Observed = SYSDATETIMEOFFSET()
	,OS_Memory_GB = MAX(convert(DECIMAL(19, 3), os.physical_memory_kb / 1024. / 1024.))
	,OS_Available_Memory_GB = max(convert(DECIMAL(19, 3), sm.available_physical_memory_kb / 1024. / 1024.))
	,SQL_Target_Server_Mem_GB = max(CASE counter_name
			WHEN 'Target Server Memory (KB)'
				THEN convert(DECIMAL(19, 3), cntr_value / 1024. / 1024.)
			END)
	,SQL_Total_Server_Mem_GB = max(CASE counter_name
			WHEN 'Total Server Memory (KB)'
				THEN convert(DECIMAL(19, 3), cntr_value / 1024. / 1024.)
			END)
	,PLE_s = MAX(CASE counter_name
			WHEN 'Page life expectancy'
				THEN cntr_value
			END)
FROM sys.dm_os_performance_counters AS pc
CROSS JOIN sys.dm_os_sys_info AS os
CROSS JOIN sys.dm_os_sys_memory AS sm;
