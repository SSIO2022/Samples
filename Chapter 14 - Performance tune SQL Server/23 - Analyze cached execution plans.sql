--The following queries can be used to analyze different aspects of cached execution plans. Note that this query may take considerable amount of time as written, so you may wish to pare down what is being output for your normal usage.

SELECT
    p.usecounts AS UseCount,
    p.size_in_bytes / 1024 AS PlanSize_KB,
    qs.total_worker_time/1000 AS CPU_ms,
    qs.total_elapsed_time/1000 AS Duration_ms,
    p.cacheobjtype + ' (' + p.objtype + ')' as ObjectType,
    db_name(convert(int, txt.dbid )) as DatabaseName,
    txt.ObjectID,
    qs.total_physical_reads,
    qs.total_logical_writes,
    qs.total_logical_reads,
    qs.last_execution_time,
    qs.statement_start_offset as StatementStartInObject,
    SUBSTRING (txt.[text], qs.statement_start_offset/2 + 1 ,
     CASE
         WHEN qs.statement_end_offset = -1
         THEN LEN (CONVERT(nvarchar(max), txt.[text]))
         ELSE qs.statement_end_offset/2 - qs.statement_start_offset/2 + 1 END)
     AS StatementText,
      qp.query_plan as QueryPlan,
      aqp.query_plan as ActualQueryPlan
FROM sys.dm_exec_query_stats AS qs
INNER JOIN sys.dm_exec_cached_plans p ON p.plan_handle = qs.plan_handle
OUTER APPLY sys.dm_exec_sql_text (p.plan_handle) AS txt
OUTER APPLY sys.dm_exec_query_plan (p.plan_handle) AS qp
OUTER APPLY sys.dm_exec_query_plan_stats (p.plan_handle) AS aqp
--tqp is used for filtering on the text version of the query plan
CROSS APPLY sys.dm_exec_text_query_plan(p.plan_handle, qs.statement_start_offset, qs.statement_end_offset) AS tqp
WHERE txt.dbid = db_id()
ORDER BY qs.total_worker_time + qs.total_elapsed_time DESC;
