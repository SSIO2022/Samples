--This provides much more information than the legacy sp_who or sp_who2 commands, as you can see displayed from this query:
--This query will return a plethora of information 
--in addition to just the session that is blocked
SELECT r.session_id, r.blocking_session_id, *
FROM sys.dm_exec_sessions s
LEFT OUTER JOIN sys.dm_exec_requests r ON r.session_id = s.session_id;
--note: requests represent actions that are executing, sessions are connections, 
--hence LEFT OUTER JOIN

--You can see details of what objects are locked by using the sys.dm_tran_locks DMO, or what locks are involved in blocking using this query:
SELECT
        t1.resource_type,
        t1.resource_database_id,
        t1.resource_associated_entity_id,
        t1.request_mode,
        t1.request_session_id,
        t2.blocking_session_id
    FROM sys.dm_tran_locks as t1
    INNER JOIN sys.dm_os_waiting_tasks as t2
        ON t1.lock_owner_address = t2.resource_address;

