--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

-- The only manual intervention required by the administrator is to grant the 
-- availability group object permissions to create databases on the secondary 
-- replicas. This is slightly different from a typical GRANT statement for permissions:
ALTER AVAILABILITY GROUP [AG_WWI] GRANT CREATE ANY DATABASE;

-- After automatic seeding, the AUTHORIZATION (also known as owner) of the database 
-- on the secondary replica might be different from the AUTHORIZATION of the 
-- database on the primary. You should check to ensure that they are the same, 
-- and alter the database if needed:
ALTER AUTHORIZATION ON DATABASE::WideWorldImporters TO [serverprincipal];
--Stop automatic seeding
ALTER AVAILABILITY GROUP [AG_WWI] --availability group name
   MODIFY REPLICA ON 'SQLSERVER-1\SQL2022' --Replica name
   WITH (SEEDING_MODE = MANUAL); --'Join Only' in SSMS
GO

-- Monitor automatic seeding
SELECT [s].* 
FROM [sys].[dm_hadr_physical_seeding_stats] AS [s]
ORDER BY [start_time_utc] desc;

-- Automatic seeding history
SELECT TOP 10 [ag].[name]
   , [dc].[database_name]
   , [s].[start_time]
   , [s].[completion_time]
   , [s].[current_state]
   , [s].[performed_seeding]
   , [s].[failure_state_desc]
   , [s].[error_code]
   , [s].[number_of_attempts]
FROM [sys].[dm_hadr_automatic_seeding] AS [s]
INNER JOIN [sys].[availability_databases_cluster] AS [dc] ON [s].[ag_db_id] = [dc].[group_database_id]
INNER JOIN [sys].[availability_groups] AS [ag] ON [s].[ag_id] = [ag].[group_id]
ORDER BY [start_time] desc;

-- If automatic seeding fails, remember to drop the unsuccessfully seeded 
-- database on the secondary replica, including the database data and log 
-- files in the file path. After you have resolved the errors and want to 
-- retry automatic seeding, you can do so by using the following example 
-- T-SQL statement. 
-- Run this code sample on the primary replica to retry automatic seeding:
ALTER AVAILABILITY GROUP [AG_WWI] --availability group name
    MODIFY REPLICA ON 'SQLSERVER-1\SQL2022' --Replica name
    WITH (SEEDING_MODE = AUTOMATIC); --Automatic Seeding
