/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

/*  Security Principals
    You can view the SID and principal_id for a login in the sys.server_principals view. */

SELECT [name], [sid], [principal_id]
FROM   [sys].[server_principals];

-- List server principals
SELECT [name], [type_desc], [is_disabled]
FROM    [sys].[server_principals]
ORDER BY [type_desc];
