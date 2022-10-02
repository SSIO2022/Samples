--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 11: IMPLEMENT HIGH AVAILABILITY AND DISASTER RECOVERY
-- T-SQL SAMPLE 3
--

--The T-SQL command to issue a forced failover, allowing for data loss, for execution on the primary replica of the availability group named AG1:
-- ALTER AVAILABILITY GROUP [AG1] FORCE_FAILOVER_ALLOW_DATA_LOSS; 

--1.	Before any failover, try to get the intended failover target secondary replica into Synchronous commit mode. Wait for the synchronization state to indicate “Synchronized”, not “Synchronizing,”, as is indicated in the availability groups dashboard or the sys.dm_hadr_database_replica_states DMV. This is the sample T-SQL code for execution on the primary replica:
ALTER AVAILABILITY GROUP [AG1] 
    MODIFY REPLICA ON N'secondary_replica_name' 
    WITH (AVAILABILITY_MODE = SYNCHRONOUS_COMMIT);

--2.	Use the REQUIRED_SYNCHRONIZED_SECONDARIES_TO_COMMIT setting, introduced in SQL Server 2017, to require a secondary replica to commit any transaction before committing to the primary replica. This is a safety measure to ensure no transactions will be lost in failover. By default, this is 0. Execute this on the primary replica:
ALTER AVAILABILITY GROUP [AG1] SET REQUIRED_SYNCHRONIZED_SECONDARIES_TO_COMMIT = 1;

--3.	Demote the primary replica to a secondary replica, and ensure that it is configured as a readable secondary replica, meaning that briefly, the availability group will have no writeable replica. This is also a safety measure to ensure no transactions will be lost in failover. Execute this on the primary replica:
ALTER AVAILABILITY GROUP [AG1] SET (ROLE = SECONDARY);

--4.	Force the failover, now with no chance of data loss, by executing this on the primary replica:
ALTER AVAILABILITY GROUP [AG1] FORCE_FAILOVER_ALLOW_DATA_LOSS;

--5.	However, yYour job, however, is not done. After a forced failover, you may need to execute the following on all secondary replicas to resume data movement after the interruption.
ALTER DATABASE [WideWorldImportersDW] 
SET HADR RESUME;

--6.	And, because it is a high-safety measure that could impact performance, don’t forget to revert the REQUIRED_SYNCHRONIZED_SECONDARIES_TO_COMMIT setting back to its original state for your environment. By default, this is 0. Execute this on the primary replica:
ALTER AVAILABILITY GROUP [AG1] SET REQUIRED_SYNCHRONIZED_SECONDARIES_TO_COMMIT = 0;
