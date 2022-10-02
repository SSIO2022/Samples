--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 9: AUTOMATE SQL SERVER ADMINISTRATION
-- T-SQL SAMPLE 1

-- Send test email
exec msdb.dbo.sp_send_dbmail
@recipients ='yournamehere@domain.com',
@subject ='test';