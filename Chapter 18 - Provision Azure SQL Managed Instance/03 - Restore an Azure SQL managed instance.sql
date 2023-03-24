--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

-- Restores to SQL managed instance are asynchronous. Should your connection to
-- your SQL managed instance be lost, the RESTORE continues. You can check the
-- status of the operations with sys.dm_operation_status. Replace "mydb" with
-- your database name in the following T-SQL script:

SELECT *
FROM sys.dm_operation_status
WHERE major_resource_id = 'mydb'
ORDER BY start_time DESC;