--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

SELECT [rgg].[group_id]
	, [rgp].[pool_id]
	, [rgp].[name] AS [Pool_Name]
	, [rgg].[name] AS [Group_Name]
	, ISNULL(COUNT([s].[session_id]), 0) AS [session_count]
FROM [sys].[dm_resource_governor_workload_groups] AS [rgg]
	LEFT OUTER JOIN [sys].[dm_resource_governor_resource_pools] AS [rgp] 
		ON [rgg].[pool_id] = [rgp].[pool_id]
	LEFT OUTER JOIN [sys].[dm_exec_sessions] AS [s] ON [s].[group_id] = [rgg].[group_id]
GROUP BY [rgg].[group_id]
	, [rgp].[pool_id]
	, [rgg].[name]
	, [rgp].[name]
ORDER BY [rgg].[name]
	, [rgp].[name];
	