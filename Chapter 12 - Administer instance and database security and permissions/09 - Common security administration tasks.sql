



--Common security administration tasks\OrphanedSids\The resolution

/*
Assuming you are using the same name for user and login, you can use the following script in the restored database to generate an ALTER USER script for your SQL Login based database principals to map them to server logins. 
*/


DECLARE @IncludeUsersWithoutLogin bit = 0;
SELECT   'ALTER USER [' + dp.name COLLATE DATABASE_DEFAULT + ']' +
		CASE WHEN sp.sid IS NOT NULL THEN
        ' WITH LOGIN = [' + dp.name + ']; '
		ELSE ' WITHOUT LOGIN' END AS SQLText,
		*
FROM     sys.database_principals AS dp
         LEFT OUTER JOIN sys.server_principals AS sp
             ON dp.sid = sp.sid
WHERE    dp.is_fixed_role = 0
    AND dp.sid NOT IN ( 0x00 ) --guest
    AND (sp.name IS NOT NULL or @IncludeUsersWithoutLogin = 1)
    AND dp.type_desc = 'SQL_USER'
    AND dp.name <> 'dbo'
ORDER BY dp.name;
GO





--Common security administration tasks\Create login with known SID

/*
In the case where you are transferring all of the logins for a server, you can actually prevent orphaned SIDS. You can re-create SQL Server–authenticated logins on multiple servers, each having the same SID. This is not possible using SSMS user interface; instead, you must accomplish this by using the CREATE LOGIN command, as shown here (or using tools we will look at later in this chapter):
*/

CREATE LOGIN [Kirby] WITH PASSWORD=N'<strongpassword>', SID = 0x5931F5B9C157464EA244B9D381DC5CCC;






--Common security administration tasks\How to migrate SQL Server logins\Move Windows-authenticated logins by using T-SQL (SQL Server only)


/*
The system catalog view sys.server_principals contains the list of Windows-authenticated logins (types ‘U’ for Windows user, and ‘G’ for Windows group). The default_database_name and default_language_name are also provided and you can script them with the login.
Here’s a sample script:
*/

--Create windows logins
SELECT CONCAT('CREATE LOGIN ', QUOTENAME(name) +
          ' FROM WINDOWS WITH DEFAULT_DATABASE =' + QUOTENAME(default_database_name)+
	  ', DEFAULT_LANGUAGE = '+ QUOTENAME(default_language_name))  + ';'AS CreateTSQL_Source 
FROM sys.server_principals
WHERE type_desc in ('WINDOWS_LOGIN','WINDOWS_GROUP')
AND name NOT LIKE 'NT SERVICE\%'
AND is_disabled = 0
ORDER BY name, type_desc;






--Common security administration tasks\How to migrate SQL Server logins\Move server roles using T-SQL (SQL Server only)

/*
The following script retrieves server role membership via SQL Server catalog views. Here’s a sample script, note that it includes options to add logins to server roles.
*/

--SERVER LEVEL ROLES
SELECT DISTINCT
 CONCAT('ALTER SERVER ROLE ',  QUOTENAME(R.NAME) , ' ADD MEMBER ' , QUOTENAME(M.NAME) ) AS CREATETSQL
FROM SYS.SERVER_ROLE_MEMBERS AS RM
INNER JOIN SYS.SERVER_PRINCIPALS R ON RM.ROLE_PRINCIPAL_ID = R.PRINCIPAL_ID
INNER JOIN SYS.SERVER_PRINCIPALS M ON RM.MEMBER_PRINCIPAL_ID = M.PRINCIPAL_ID
WHERE R.IS_DISABLED = 0 AND M.IS_DISABLED = 0 -- IGNORE DISABLED ACCOUNTS
AND M.NAME NOT IN ('DBO', 'SA'); -- IGNORE BUILT-IN ACCOUNTS





--Common security administration tasks\How to migrate SQL Server logins\Move server permissions using T-SQL (SQL Server only)


--Here is a script that will output a script of your permissions to groups:

--SERVER LEVEL SECURITY
SELECT   RM.state_desc + N' ' + RM.permission_name + CASE WHEN E.name IS NOT NULL
                                                              THEN 'ON ENDPOINT::[' + E.name + '] '
                                                          ELSE ''
                                                     END + N' TO '
         + CAST(QUOTENAME(U.name COLLATE DATABASE_DEFAULT) AS nvarchar(256)) + ';' AS CREATETSQL
FROM     sys.server_permissions AS RM
         INNER JOIN sys.server_principals AS U
             ON RM.grantee_principal_id = U.principal_id
         LEFT OUTER JOIN sys.endpoints AS E
             ON E.endpoint_id = RM.major_id
                 AND RM.class_desc = 'ENDPOINT' 
WHERE  u.is_fixed_role = 0  --note, public is not considered a fixed role because you can grant it permissions
--NOTE: this ignores many of the built in accounts, but if you have made changes to these 
--accounts you may need to make changes to the WHERE clause
AND    U.name NOT LIKE '##%' -- IGNORE SYSTEM ACCOUNTS
    AND U.name NOT IN ( 'DBO', 'SA') -- IGNORE BUILT-IN ACCOUNTS
	AND U.name NOT LIKE 'NT SERVICE%'
	AND U.name NOT LIKE 'NT AUTHORITY%'
ORDER BY RM.permission_name, U.name;

