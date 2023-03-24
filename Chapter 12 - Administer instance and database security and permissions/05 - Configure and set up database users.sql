/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

-- Security Prinicpals\Database Principals\Users mapped to Windows Authentication principals directly

/*  In the previous section, we created the login for [Domain\Fred], so the 
    CREATE USER statement referenced that login. However, a user could be 
    created for that login regardless of the existence of the explicit 
    login principal. */
CREATE USER [Domain\Sam] FOR LOGIN [Domain\Sam];

-- Security Prinicpals\Database Principals\Database roles\Built-in Database roles\db_owner

/*  The db_owner role does not specifically confer the CONTROL DATABASE permission 
    to it's members, but is equivalent in terms of what it is allowed to do. Different 
    from the sysadmin server role, the db_owner role does not bypass DENY permissions.
    For example: */
CREATE USER [fred] WITHOUT LOGIN;
ALTER ROLE [db_owner] ADD MEMBER [fred];
DENY SELECT ON [dbo].[test] TO [fred];
GO

EXECUTE AS USER = 'fred';

SELECT *
FROM [dbo].[test];
GO

/*  (While impersonating dbo, the user can easily revoke any denied rights, so it is 
    important to audit users with elevated rights if they have access to any sensitive 
    data.) */
EXECUTE AS USER = 'dbo'

SELECT *
FROM [dbo].[test];
GO

REVERT; 
REVERT; -- Revert twice, once to get back to fred, and another to get back to your security context.

/*  The only users in the database who can add or remove members from built-in database 
    roles are members of the db_owner role or principals that hold AUTHORIZATION rights 
    for the database. However, a loophole to this is a database role such as: */
CREATE ROLE [ALLPowerful];
ALTER ROLE [db_owner] ADD MEMBER [allPowerful];
GO
