/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

SELECT SYSDATETIME() AS [when_observed]
	, [s].[session_id]
	, [r].[request_id]
	, [s].[status] AS [session_status] -- Running, sleeping, dormant, preconnect 
	, [r].[status] SA [request_status] -- Running, runnable, suspended, sleeping, background 
	, [r].[blocking_session_id] AS [blocked_by]
	, DB_NAME([r].[database_id]) AS [database_name]
	, [s].[login_time]
	, [r].[start_time]
	, CASE WHEN [r].[statement_start_offset] = 0
			AND [r].[statement_end_offset] = 0 THEN 
				LEFT([est].[text], 4000)
			ELSE 
				SUBSTRING(est.[text], [r].[statement_start_offset] / 2 + 1, 
							CASE WHEN [r].[statement_end_offset] = - 1 THEN 
								LEN(CONVERT(NVARCHAR(MAX), [est].[text]))
							ELSE 
								-- the actual query text is stored as NVARCHAR 
								-- so we must divide by 2 for the character offsets
								[r].[statement_end_offset] / 2 - [r].[statement_start_offset] / 2 + 1
							END)
		END AS [query_text]  
	, [qp].[query_plan]
	, LEFT([p].[cacheobjtype] + '(' + [p].[objtype] + ')', 35) AS [cacheobjtype]
	, [est].[objectid]
	, [s].[login_name]
	, [s].[client_interface_name]
	, [e].[name] AS [endpoint_name]
	, [e].[protocol_desc] AS [protocol]
	, [s].[host_name]
	, [s].[program_name]
	, [r].[cpu_time] AS [cpu_time_s]
	, [r].[total_elapsed_time] AS [tot_time_s]
	, [r].[wait_time] AS [wait_time_s]
	, [r].[wait_type]
	, [r].[wait_resource]
	, [r].[last_wait_type]
	, [r].[reads]
	, [r].[writes]
	, [r].[logical_reads] -- Accumulated request statistics 
FROM [sys].[dm_exec_sessions] AS [s]
	LEFT OUTER JOIN [sys].[dm_exec_requests] AS [r] ON [r].[session_id] = [s].[session_id]
	LEFT OUTER JOIN [sys].[endpoints] AS [e] ON [e].[endpoint_id] = [s].[endpoint_id]
	LEFT OUTER JOIN [sys].[dm_exec_cached_plans] AS [p] ON [p].[plan_handle] = [r].[plan_handle]
	OUTER APPLY [sys].[dm_exec_query_plan]([r].[plan_handle]) AS [qp]
	OUTER APPLY [sys].[dm_exec_sql_text]([r].[sql_handle]) AS [est]
	LEFT OUTER JOIN [sys].[dm_exec_query_stats] AS [stat] ON [stat].[plan_handle] = [r].[plan_handle]
		AND [r].[statement_start_offset] = [stat].[statement_start_offset]
		AND [r].[statement_end_offset] = [stat].[statement_end_offset]
WHERE 1 = 1 -- Veteran trick that makes for easier commenting of filters 
	AND [s].[session_id] >= 50 --retrieve only user spids 
	AND [s].[session_id] <> @@SPID --ignore this session 
ORDER BY [r].[blocking_session_id] DESC
	, [s].[session_id] ASC;
