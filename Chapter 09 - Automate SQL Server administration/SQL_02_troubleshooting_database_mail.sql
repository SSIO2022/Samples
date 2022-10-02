--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 9: AUTOMATE SQL SERVER ADMINISTRATION
-- T-SQL SAMPLE 2

-- Find recent unsent emails
--Find recent unsent emails
SELECT m.send_request_date, m.recipients, m.copy_recipients, m.blind_copy_recipients
, m.[subject], m.send_request_user, m.sent_status
FROM msdb.dbo.sysmail_allitems m
WHERE
-- Only show recent day(s)
m.send_request_date > dateadd(day, -3, sysdatetime())
-- Possible values are sent (successful), unsent (in process),
-- retrying (failed but retrying), failed (no longer retrying)
AND m.sent_status<>’sent’ ORDER BY m.send_request_date DESC;
