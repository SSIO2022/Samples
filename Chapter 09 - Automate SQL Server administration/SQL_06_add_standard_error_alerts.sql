--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 9: AUTOMATE SQL SERVER ADMINISTRATION
-- T-SQL SAMPLE 6
--
--TODO: Find/replace the current operator_name value in this document with your intended operator name

USE [msdb]
GO
EXEC msdb.dbo.sp_add_alert @name=N'error severity 16', 
		@message_id=0, 
		@severity=16, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1;
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error severity 16', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error severity 17', 
		@message_id=0, 
		@severity=17, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1;
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error severity 17', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error severity 18', 
		@message_id=0, 
		@severity=18, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1;
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error severity 18', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error severity 19', 
		@message_id=0, 
		@severity=19, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1;
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error severity 19', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

/*
EXEC msdb.dbo.sp_add_alert @name=N'error severity 20', 
		@message_id=0, 
		@severity=20, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1;
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error severity 20', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO
*/

EXEC msdb.dbo.sp_add_alert @name=N'error severity 21', 
		@message_id=0, 
		@severity=21, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1;
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error severity 21', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error severity 22', 
		@message_id=0, 
		@severity=22, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1;
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error severity 22', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error severity 23', 
		@message_id=0, 
		@severity=23, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1;
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error severity 23', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error severity 24', 
		@message_id=0, 
		@severity=24, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1;
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error severity 24', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error severity 25', 
		@message_id=0, 
		@severity=25, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1;
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error severity 25', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error 3041 - backup failure', 
		@message_id=3041, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=600, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000';
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error 3041 - backup failure', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error 825 - read-retry error (severity 10)', 
		@message_id=825, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000';
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error 825 - read-retry error (severity 10)', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error 854 - possible memory corruption (severity 10)', 
		@message_id=854, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000';
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error 854 - possible memory corruption (severity 10)', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error 855 - possible memory corruption (severity 10)', 
		@message_id=855, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000';
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error 855 - possible memory corruption (severity 10)', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error 856 - possible memory corruption (severity 10)', 
		@message_id=856, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000';
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error 856 - possible memory corruption (severity 10)', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'error 3624 - assertion failure (severity 20)', 
		@message_id=3624, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=60, 
		@include_event_description_in=1, 
		@job_id=N'00000000-0000-0000-0000-000000000000';
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'error 3624 - assertion failure (severity 20)', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'deadlocks', 
		@message_id=0, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:Locks|Number of Deadlocks/sec|_Total|>|0', 
		@job_id=N'00000000-0000-0000-0000-000000000000';
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'deadlocks', @operator_name=N'OperatorNameHere', @notification_method = 1;
GO
