/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

-- Security Principals\How permissions accumulate

/*  Consider the following opposing GRANT and DENY statements run from an 
    administrative account on the WideWorldImporters sample database (which you 
    can find here: https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-oltp-install-configure).   */
CREATE ROLE [SalesSchemaRead] GRANT SELECT on SCHEMA::[sales] to [SalesSchemaRead];
DENY SELECT on OBJECT::[sales].[InvoiceLines] to [SalesSchemaRead];

-- Next, create a login-less user to test with. 
CREATE USER TestPermissions WITHOUT LOGIN;
ALTER ROLE SalesSchemaRead ADD MEMBER TestPermissions;

/*  As a result, assuming the database user TestPermissions is only a member of 
    this single role SalesSchemaRead, it would have permissions to execute 
    SELECT statements on every object in the Sales schema, except for the 
    [Sales].[SalesInvoice] table. Let’s assume that no other permissions or role
     memberships have been granted to the database user TestPermissions. If 
     this is run by user TestPermissions: */

USE [WideWorldImporters];
GO

EXECUTE AS USER = 'TestPermissions';

SELECT TOP 100 * FROM [Sales].[Invoices]; 
SELECT TOP 100 * FROM [Sales].[InvoiceLines];

REVERT;

/*  Now, let's add another role, that has the specific purpose of not allowing 
    access to the Sales schema: */
CREATE ROLE [SalesSchemaDeny]; 

DENY SELECT on SCHEMA::[sales] to [SalesSchemaDeny];

ALTER ROLE [SalesSchemaDeny] ADD MEMBER [TestPermissions];

-- If you execute the following:
REVOKE SELECT on SCHEMA::[sales] to [SalesSchemaDeny];

-- Now, the only thing that will be denied to TestPermissions is access to InvoiceLines.
