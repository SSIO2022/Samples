SELECT * 
FROM sys.dm_exec_sessions
WHERE db_name(database_id) = 'database_name';
