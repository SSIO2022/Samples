--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 9: AUTOMATE SQL SERVER ADMINISTRATION
-- T-SQL SAMPLE 4

-- Add new category
EXEC msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Health Check';