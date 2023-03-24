/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

-- Security Prinicpals\Server level roles\Built-in server roles\##MS_DatabaseManager## 

/*	For example, consider the following script. In it, we will create a new 
	database owned by sa, then one by a new principal named TestDbManager. The 
	only thing this login will not be able to do with the database is change the 
	owner, but it can drop the database, and make important setting changes. */
USE [Master];
GO

-- Using standard security for simplicity
CREATE LOGIN [TestDbManager] WITH PASSWORD = '<strong password>'
GO

ALTER SERVER ROLE [##MS_DatabaseManager##] ADD MEMBER [TestDbManager]
GO

/*	Now, still as the sysadmin enabled login you are using to administer your test 
	instance, create a database and make it owned by the sa built in login. */
CREATE DATABASE [TestDropSa]
ALTER AUTHORIZATION ON DATABASE::[TestDropSa] TO [sa];
GO

-- Now, impersonating the TestDbManager principal, attempt to create, alter, and drop databases.

EXECUTE AS LOGIN = 'TestDbManager';

/*	I suggest you always test that you are in the right context when you are 
	writing test scripts. Too often you think it worked, but you were in the 
	wrong security context. */
IF SUSER_SNAME() <> 'TestDbManager'
	THROW 50000, 'You are not in the expected context', 1;

-- Then test that you can do what you expect.
CREATE DATABASE [TestDrop];
ALTER AUTHORIZATION ON DATABASE::[TestDrop] TO [sa];

/*	This command fails with the following error, indicating that it does not 
	have permissions to change the owner. The login will be able to alter 
	authorization to itself, or any other account they can access. */
ALTER DATABASE [TestDropSa] SET SINGLE_USER;
ALTER DATABASE [TestDropSa] SET READ_COMMITTED_SNAPSHOT ON;

-- And you can drop the databases:
DROP DATABASE [TestDrop];
DROP DATABASE [TestDropSa];
GO

REVERT; -- Go back to original, sysadmin role

/* 	Note that being in the ##MS_DatabaseManager## role does not confer 
	any rights in the databases created, but if the role member make 
	themselves the owner of the database, they will have access. 
	You can determine this using this query: */
SELECT [databases].[name] AS [databaseName]
FROM [sys].[databases]
	INNER JOIN [sys].[server_principals]
		ON [databases].[owner_sid] = [server_principals].[sid]
WHERE [server_principals].[name] = 'TestDbManager';

-- Security Prinicpals\Built-in server roles\##MS_LoginManager## 

/*	As an example, in the next set of statement, I will show you the 
	basics of with this role can do. I start out with a new login, and 
	I put it in the ##MS_LoginManager## server role. */
CREATE LOGIN [TestLoginManager] WITH PASSWORD = '<strongpassword>';
GO
ALTER SERVER ROLE [##MS_LoginManager##] ADD MEMBER [TestLoginManager];
GO      

-- Now, change to the security context of the TestLoginManager login:
EXECUTE AS LOGIN = 'TestLoginManager';

/*	And now, create a new login. (Be careful to test your security context 
	when doing these tests. It is easy to get lost and be confused by 
	something working or not working because you are not actually in the 
	security context you expect.) */
CREATE LOGIN [WhatCanIDo] with PASSWORD = '<strongpassword>';

/*	The next question is “what else can you do to the login?”  You can add 
it to a role that it is a member of. */
ALTER SERVER ROLE [##MS_LoginManager##] ADD MEMBER [WhatCanIDo];

/* 	But each of the next three statements will fail, the first two will 
	question if the role exists. */
ALTER SERVER ROLE [##MS_DatabaseConnector##] ADD MEMBER [WhatCanIDo];
ALTER SERVER ROLE [sysadmin] ADD MEMBER [WhatCanIDo];

-- The next statement will fail with the error “Grantor does not have GRANT permission”
GRANT CONTROL SERVER TO [WhatCanIDo];

/*	This is an important distinction between the ##MS_LoginManager## role 
	and the securityadmin role. It is allowed to grant new rights that it 
	doesn’t have (though not membership to a role it is not a member of). 

	If you want your new login to be able to grant rights, you will need to 
	give it either give the account CONTROL rights over a resource, or use 
	the WITH GRANT OPTION on your GRANT statements, which will allow the 
	account to GRANT the same rights to other principals. Go back to your 
	sysadmin level account. */
REVERT;

/*	Then add the login to the ##MS_DatabaseConnector##, and you will see 
	that you can now add your WhatCanIDo account to it as well. */
ALTER SERVER ROLE [##MS_DatabaseConnector##] ADD MEMBER [TestLoginManager];

EXECUTE AS LOGIN = 'TestLoginManager';

ALTER SERVER ROLE [##MS_DatabaseConnector##] ADD MEMBER [WhatCanIDo];
REVERT;

/*	Security Prinicpals\Server level roles\User defined server roles
	Create a new custom server role */
CREATE SERVER ROLE [SupportViewServer];
GO

/*	Grant permissions to the custom server role
	Run DMOs, see server information */
GRANT VIEW SERVER STATE to [SupportViewServer];

-- See metadata of any database
GRANT VIEW ANY DATABASE to [SupportViewServer];

-- Set context to any database
GRANT CONNECT ANY DATABASE to [SupportViewServer];

-- Permission to SELECT from any data object in any databases
GRANT SELECT ALL USER SECURABLES to [SupportViewServer];
GO

-- Add the DBA team’s accounts
ALTER SERVER ROLE [SupportViewServer] ADD MEMBER [domain\Kirby];
ALTER SERVER ROLE [SupportViewServer] ADD MEMBER [domain\Colby];
ALTER SERVER ROLE [SupportViewServer] ADD MEMBER [domain\David];
