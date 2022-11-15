/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

-- This sample is a good foundation script for monitoring.

/* Monitor availability group Health on a secondary replica, this query returns
   a row for every secondary database on the server instance. On the primary 
   replica, this query returns a row for each primary database and an additional 
   row for the corresponding secondary database. Recommended executing on the 
   primary replica. */
IF NOT EXISTS (SELECT @@SERVERNAME
    FROM [sys].[dm_hadr_availability_replica_states] AS [rs]
    WHERE [rs].[is_local] = 1
    and [rs].[role_desc] = 'PRIMARY')
   SELECT 'Recommend: Run script on Primary, incomplete data on Secondary.';

SELECT [ag].[name] AS [AG]
   , [ar].[replica_server_name] + ' ' +
      CASE WHEN is_local = 1 THEN '(local)' 
      ELSE '' END AS [Instance]
   , DB_NAME([dm].[database_id]) AS [DB]
   , CASE WHEN [last_received_time] IS NULL THEN
         'PRIMARY (Connections: ' + [ar].[primary_role_allow_connections_desc] + ')'
      ELSE 'SECONDARY (Connections: ' + [ar].[secondary_role_allow_connections_desc] + ')' END AS [Replica_Role]
   , [dm].[synchronization_state_desc]
   , [dm].[synchronization_health_desc]
   , [ar].[availability_mode_desc]
   , [ar].[failover_mode_desc]
   , CASE [is_suspended] 
      WHEN 1 THEN [suspend_reason_desc] 
      ELSE 'NO' END AS [Suspended]
   , [last_received_time]
   , [last_commit_time]
   , [dm].[secondary_lag_seconds]
   , [redo_queue_size]/1024.0 AS [Redo_queue_size_MB]
   , [dm].[secondary_lag_seconds]
   , [ar].[backup_priority]
   , [ar].[endpoint_url]
   , [ar].[read_only_routing_url]
   , [ar].[session_timeout]
FROM [sys].[dm_hadr_database_replica_states] AS [dm]
   INNER JOIN [sys].[availability_replicas] AS [ar]
      ON [dm].[replica_id] = [ar].[replica_id] and [dm].[group_id] = [ar].[group_id]
   INNER JOIN [sys].[availability_groups] [ag] on [ag].[group_id] = [dm].[group_id]
ORDER BY [ag], [Instance], [DB], [Replica_Role];

/* For more information on the data returned in this DMV, read on to the next code 
   sample and reference:
   https://docs.microsoft.com/sql/relational-databases/system-dynamic-management-views/[sys]-dm-hadr-database-replica-cluster-states-transact-sql.
*/

/* You should monitor the system table msdb.dbo.suspect_pages and the DMV s
   ys.dm_hadr_auto_page_repair, which will contain entries of these events. 
   For example: Check for suspect pages (hopefully 0 rows returned) */
SELECT * 
FROM [msdb].[dbo].[suspect_pages] 
WHERE ([event_type] <= 3);

-- Check for autorepair events (hopefully 0 rows returned)
SELECT DB_NAME([database_id]) AS [db]
   , * 
FROM [sys].[dm_hadr_auto_page_repair];


/* Monitor availability groups performance on a secondary replica, this 
   query returns a row for every secondary database on the server instance. 
   On the primary replica, this query returns a row for each primary 
   database and an additional row for the corresponding secondary database. */
IF NOT EXISTS ( SELECT @@SERVERNAME
               FROM [sys].[dm_hadr_availability_replica_states]
               WHERE [is_local] = 1
                  AND [role_desc] = 'PRIMARY')
   SELECT 'Recommend: Run This Script on Primary Replica';

DECLARE @BytesFlushed_Start_ms BIGINT
   , @BytesFlushed_Start BIGINT
   , @BytesFlushed_End_ms BIGINT
   , @BytesFlushed_End BIGINT;

-- Compare counter samples
DECLARE @TransactionDelay TABLE
( [DB] SYSNAME NOT NULL
   , [TransactionDelay_Start_ms] DECIMAL(19,2) NULL
   , [TransactionDelay_end_ms] DECIMAL(19,2) NULL
   , [TransactionDelay_Start] DECIMAL(19,2) NULL
   , [TransactionDelay_end] DECIMAL(19,2) NULL
   , [MirroredWriteTranspersec_Start_ms] DECIMAL(19,2) NULL
   , [MirroredWriteTranspersec_end_ms] DECIMAL(19,2) NULL
   , [MirroredWriteTranspersec_Start] DECIMAL(19,2) NULL
   , [MirroredWriteTranspersec_end] DECIMAL(19,2) NULL
   , UNIQUE CLUSTERED ([DB])
);

INSERT INTO @TransactionDelay ([DB], [TransactionDelay_Start_ms], [TransactionDelay_Start])
SELECT pc.instance_name AS [DB]
   , MAX([ms_ticks]) AS [TransactionDelay_Start_ms]
   , MAX(convert(DECIMAL(19,2), pc.cntr_value)) AS [TransactionDelay_start]
FROM [sys].[dm_os_sys_info] AS [si]
   CROSS APPLY [sys].[dm_os_performance_counters] AS [pc]
WHERE [object_name] like '%database replica%'
   -- cumulative transaction delay in ms
   AND [counter_name] = 'transaction delay'
GROUP BY [pc].[instance_name]; 

UPDATE [t]
SET [MirroredWriteTranspersec_Start_ms] = [t2].[MirroredWriteTranspersec_Start_ms]
   , [MirroredWriteTranspersec_Start] = [t2].[MirroredWriteTranspersec_Start]
FROM @TransactionDelay [t]
INNER JOIN (SELECT [DB] = [pc].[instance_name]
               , MAX([ms_ticks]) AS [MirroredWriteTranspersec_Start_ms]
               , MAX(CONVERT(DECIMAL(19,2), [pc].[cntr_value])) AS [MirroredWriteTranspersec_Start] 
            FROM [sys].[dm_os_sys_info] AS [si]
               CROSS APPLY [sys].[dm_os_performance_counters] AS [pc]
            WHERE [object_name] LIKE '%database replica%'
               -- actually a cumulative transactions count, not per sec
               AND [counter_name] = 'mirrored write transactions/sec'   
            GROUP BY [pc].[instance_name]) [t2] ON [t].[DB] = [t2].[DB];

SELECT @BytesFlushed_Start_ms = MAX([ms_ticks])
   /* the availability database with the highest potential for data_loss becomes 
      the limiting value for RPO compliance. */
   , @BytesFlushed_Start = MAX([cntr_value]) 
FROM [sys].[dm_os_sys_info]
   CROSS APPLY [sys].[dm_os_performance_counters] 
WHERE [counter_name] LIKE 'Log Bytes Flushed/sec%';

/* Adjust sample duration between measurements, so we can observe the change in the 
   counters and average the difference per second */
WAITFOR DELAY '00:00:05'; 

UPDATE [t]
SET [TransactionDelay_end_ms] = t2.TransactionDelay_end_ms
   , [TransactionDelay_end] = t2.TransactionDelay_end
FROM @TransactionDelay [t]
   INNER JOIN (SELECT pc.instance_name AS [DB]
                  , MAX([ms_ticks]) AS [TransactionDelay_end_ms]
                  , MAX(CONVERT(DECIMAL(19,2), [pc].[cntr_value])) AS [TransactionDelay_end]
               FROM [sys].[dm_os_sys_info] AS [si]
                  CROSS APPLY [sys].[dm_os_performance_counters] AS [pc]
               WHERE [object_name] like '%database replica%'
                  --cumulative transaction delay in ms
                  AND [counter_name] = 'transaction delay' 
               GROUP BY [pc].[instance_name]) [t2] ON [t].[DB] = [t2].[DB];

UPDATE [t]
SET MirroredWriteTranspersec_end_ms = t2.MirroredWriteTranspersec_end_ms
   , MirroredWriteTranspersec_end = t2.MirroredWriteTranspersec_end
FROM @TransactionDelay t
   INNER JOIN (SELECT DB = pc.instance_name
                  , MAX([ms_ticks]) AS [MirroredWriteTranspersec_end_ms]
                  , MAX(convert(DECIMAL(19,2), pc.cntr_value)) AS [MirroredWriteTranspersec_end]
               FROM [sys].[dm_os_sys_info] AS [si]
               CROSS APPLY [sys].[dm_os_performance_counters] AS [pc]
               WHERE [object_name] like '%database replica%'
                  -- actually a cumulative transactions count, not per sec
                  AND [counter_name] = 'mirrored write transactions/sec' 
               GROUP BY [pc].[instance_name]) [t2] ON [t].[DB] = [t2].[DB];

SELECT @BytesFlushed_End_ms = MAX([ms_ticks])
   , @BytesFlushed_End = MAX([cntr_value]) 
FROM [sys].[dm_os_sys_info]
   CROSS APPLY [sys].[dm_os_performance_counters] 
WHERE [counter_name] LIKE 'Log Bytes Flushed/sec%';

DECLARE @LogBytesFushed DECIMAL(19,2);

SET @LogBytesFushed = (@BytesFlushed_End - @BytesFlushed_Start) / NULLIF(@BytesFlushed_End_ms - @BytesFlushed_Start_ms,0);

-- Current replica metrics
SELECT [ag].[name] AS [ag]
   , [ar].[replica_server_name] + ' ' + 
      CASE WHEN is_local = 1 THEN 
         '(local)' 
      ELSE 
         ''
      END AS [Instance]
   , DB_NAME([dm].[database_id]) AS [DB]
   , CASE WHEN [last_received_time] IS NULL THEN 
      'PRIMARY (Connections: '+ [ar].[primary_role_allow_connections_desc]+')' 
      ELSE 'SECONDARY (Connections: '+ [ar].[secondary_role_allow_connections_desc]+')' END AS [Replica_Role]
   , [Last_received_time]
   , [Last_commit_time]
   , CONVERT(DECIMAL(19,2),[dm].[redo_queue_size]/1024.0) AS [Redo_queue_size_MB] -- KB
   , CONVERT(DECIMAL(19,2),[dm].[redo_rate]/1024.0) AS [Redo_rate_MB_per_s] -- KB/s
   -- only part of RTO. NULL value on secondary replica indicates no sampled activity.
   , CONVERT(DECIMAL(19,2), [dm].[redo_queue_size] * 1.0 / NULLIF([dm].[redo_rate] * 1.0 , 0)) AS [Redo_Time_Left_s_RTO]
   , CONVERT(DECIMAL(19,2),[dm].[log_send_queue_size] * 1.0 / NULLIF(@LogBytesFushed , 0)) AS [Log_Send_Queue_RPO]
   -- Rate. NULL value on secondary replica indicates no sampled activity.
   , (td.MirroredWriteTranspersec_end -td.MirroredWriteTranspersec_start) AS [Sampled_Transactions_count]
   , (td.TransactionDelay_end - td.TransactionDelay_start) AS [Sampled_Transaction_Delay_ms]
   -- Transaction Delay numbers will be 0 if there is no synchronous replica for the DB
   , CONVERT(DECIMAL(19,2), 
      (td.TransactionDelay_end - td.TransactionDelay_Start) / 
      ((td.TransactionDelay_end_ms - td.TransactionDelay_Start_ms) / 1000.0)) AS [Avg_Sampled_Transaction_Delay_ms_per_s]
   , CONVERT(DECIMAL(19,2), ((td.MirroredWriteTranspersec_end - td.MirroredWriteTranspersec_start) / 
      ((td.MirroredWriteTranspersec_End_ms - td.MirroredWriteTranspersec_Start_ms) / 1000.))) AS [Transactions_per_s]
   , [dm].[secondary_lag_seconds]
   , [dm].[synchronization_state_desc]
   , [dm].[synchronization_health_desc]
   , [ar].[availability_mode_desc]
   , [ar].[failover_mode_desc]
   , CASE [is_suspended] 
      WHEN 1 THEN 
         [suspend_reason_desc] 
      ELSE 'NO' 
      END AS [Suspended]
   , [ar].[backup_priority] -- Backup preference priorities for reference
   , [ar].[modify_date] -- Replica modified date
   , [ar].[endpoint_url] -- EndPoint URL for reference
   , [ar].[read_only_routing_url] -- Routing URL for reference
FROM [sys].[dm_hadr_database_replica_states] AS [dm]
   INNER JOIN [sys].[availability_replicas] AS [ar] ON [dm].[replica_id] = [ar].[replica_id] 
      AND [dm].[group_id] = [ar].[group_id]
INNER JOIN @TransactionDelay AS [td] on [td].[DB] = DB_NAME([dm].[database_id])
INNER JOIN [sys].[availability_groups] [ag] ON [ag].[group_id] = [dm].[group_id]
ORDER BY [ag], [Instance], [DB], [Replica_Role];
GO  
