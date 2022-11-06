
--Security Prinicpals\Configure login server principals\Commonly used server privileges

/*
It is not a simple task to determine exactly how a server principal obtained the privileges they have, but it is straightforward to determine what effective rights a user has at the server level using fn_my_permissions, which you can use at the server or database level to see what the current security context has access to. If you run this as a sysadmin, you will see every privilege listed.
*/


CREATE LOGIN ListEffectivePermissions WITH PASSWORD = '<strong password>';
GRANT CONNECT ANY DATABASE TO ListEffectivePermissions;

/*
Next, we check the login’s effective permissions by passing SERVER to the function (the first parameter is for the object to check permissions), which we will use at the database level.
*/

EXECUTE AS LOGIN = 'ListEffectivePermissions';
SELECT permissions.permission_name
FROM    fn_my_permissions(NULL, 'SERVER') AS permissions 
REVERT;



--Security Prinicpals\Database Principals\Users mapped to logins and groups

/*
Users mapped to logins are by and far the most common type you will come in contact with. For example, if you had created a standard login named Bob and a Windows authenticated login named [Domain\Fred], using the following code:
*/

--examples, not necessarily to be executed
CREATE LOGIN Bob WITH PASSWORD = 'Bob Is A Graat Guy'; --Misspellings in passwords can be helpful!
CREATE LOGIN [Domain\Fred] FROM WINDOWS;


--Then you could create users for these logins using:

CREATE USER [Domain\Fred] FOR LOGIN [Domain\Fred];
CREATE USER Bob FOR LOGIN Bob;


/*
There is nothing stating that the name of the login must match the domain name, but it is a very typical way to create users, and helps to document your database users and where they come from. The following is perfectly legal syntax as well:
*/

CREATE USER fred FOR LOGIN [Domain\Fred];

--Not that you cannot use a \ character in a login name unless it is a Windows Authentication based login. Trying to execute either of the following statements:

CREATE LOGIN [Domain\Fred] WITH PASSWORD = '<strong password>';
CREATE USER [Dog\Gone] FOR LOGIN [Dog\Gone]; 

