/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

-- Security Prinicpals\Database Principals\Database roles\Custom database roles

/*  As with server roles, the key to creating custom database roles is to have 
    a solid understanding of the tasks you wish the members of the role should 
    be able to do and the permission set required to accomplish these tasks. It 
    is unlikely that all users in a database will need the same data access, 
    and not all read-only access will be the same. */

-- Create a new custom database role
USE [WideWorldImporters];
GO

-- Create the database role
CREATE ROLE [WebsiteExecute] AUTHORIZATION [dbo];
GO

-- Grant access rights to a specific schema in the database
GRANT EXECUTE ON Schema::[Website] TO [WebsiteExecute];
GO

/*  Like users, custom database roles can themselves be made members of other 
    database roles. Be careful with putting built-in database roles as members 
    of custom roles, as you may end up giving users more rights than you expect. 
    Keep in mind that it is a very good practice to use proper naming of 
    roles so that you don’t have a role like: */
CREATE ROLE [ReadOneTable] AUTHORIZATION [dbo];

-- That actually has athe rights of the db_owner role:
ALTER ROLE [db_owner] ADD MEMBER [ReadOneTable];

/*  Security Principals\Database Principals\Database roles\Custom database 
    roles\Using role membership to handle environment differences */

/*  If you only ever grant and deny privileges to roles, you will be able to 
    put that security code into your source control system, and test it in DEV, 
    QA, and then apply it to production. You might create the following role: */
CREATE ROLE [SalesSchemaRead];

-- And grant it rights:
GRANT SELECT ON SCHEMA::[Sales] TO [SalesSchemaRead];

/*  Since you will have then tested that the role works, you will be sure that 
    it works in every environment. */
