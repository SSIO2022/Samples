--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

SELECT *
FROM [sys].[dm_exec_sessions]
WHERE DB_NAME([database_id]) = 'database_name';
