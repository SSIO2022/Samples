--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

CREATE EVENT SESSION [page_splits] ON SERVER
    ADD EVENT sqlserver.page_split (ACTION(sqlserver.database_name, sqlserver.sql_text)) ADD TARGET package0.event_file (
    SET filename = N'page_splits'
    , max_file_size = (100)
    )
    , ADD TARGET package0.histogram (
    SET filtering_event_name = N'sqlserver.page_split'
    , source = N'database_id'
    , source_type = (0)
    )
    --Start session at server startup 
    WITH (STARTUP_STATE = ON);
GO

--Start the session now 
ALTER EVENT SESSION [page_splits] ON SERVER STATE = START;