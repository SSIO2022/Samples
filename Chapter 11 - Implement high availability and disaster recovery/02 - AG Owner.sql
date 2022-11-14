--################################################################[ar]##############
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

-- What server principal owns an availability group replica?
-- Run this on EACH replica SQL instance, it may be different.
SELECT [ar].[replica_server_name]
	,[ag].[name] AS [ag_name]
	,[ar].[owner_sid]
	,[sp].[name]
FROM [sys].[availability_replicas] AS [ar]
	LEFT JOIN [sys].[server_principals] AS [sp]
		ON [sp].[sid] = [ar].[owner_sid] 
	INNER JOIN [sys].[availability_groups] AS [ag]
		ON [ag].[group_id] = [ar].[group_id]
WHERE [ar].[replica_server_name] = SERVERPROPERTY('ServerName') ;

-- Changing the owner of the availability group replica to the instance’s sa   
-- login, on instances with mixed mode authentication turned on, is also an 
-- acceptable and common practice; for example:
ALTER AUTHORIZATION ON AVAILABILITY GROUP::[AG1]   to [domain\serviceaccount];
