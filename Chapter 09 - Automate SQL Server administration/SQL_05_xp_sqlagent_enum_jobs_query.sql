--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 9: AUTOMATE SQL SERVER ADMINISTRATION
-- T-SQL SAMPLE 5
-- Jobs still running 
DECLARE @xp_sqlagent_enum_jobs TABLE (
    id INT NOT NULL IDENTITY(1, 1) PRIMARY KEY
    , Job_ID UNIQUEIDENTIFIER NOT NULL
    , Last_Run_Date INT NOT NULL
    , Last_Run_Time INT NOT NULL
    , Next_Run_Date INT NOT NULL
    , Next_Run_Time INT NOT NULL
    , Next_Run_Schedule_ID INT NOT NULL
    , Requested_To_Run INT NOT NULL
    , Request_Source INT NOT NULL
    , Request_Source_ID VARCHAR(100) NULL
    , Running INT NOT NULL
    , Current_Step INT NOT NULL
    , Current_Retry_Attempt INT NOT NULL
    , [State] INT NOT NULL
    );

INSERT INTO @xp_sqlagent_enum_jobs
EXEC master.dbo.xp_sqlagent_enum_jobs 1, '';

SELECT j.name
    , state_desc = CASE ej.STATE
        WHEN 0 THEN 'not idle or suspended'
        WHEN 1 THEN 'Executing'
        WHEN 2 THEN 'Waiting for thread'
        WHEN 3 THEN 'Between retries'
        WHEN 4 THEN 'Idle'
        WHEN 5 THEN 'Suspended'
        WHEN 7 THEN 'Performing completion actions'
                -- https://docs.microsoft.com/sql/relational-databases/system-stored-procedures/sp-help-job-transact-sql
        END
    , *
FROM msdb.dbo.sysjobs j
LEFT OUTER JOIN @xp_sqlagent_enum_jobs ej ON j.job_id = ej.Job_ID
ORDER BY j.name;