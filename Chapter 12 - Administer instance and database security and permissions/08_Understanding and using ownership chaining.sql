
--Permissions\Authorization\A demonstration of permissions with views, stored procedures, and functions

/*
Let’s demonstrate with a simple exercise, in which we will create a testing user and a testing table in the tempdb database (you can use any database where you have rights to create objects.) Run the code in this demonstration section while logged in as a member of the sysadmin role:
*/

USE tempdb;
GO
CREATE USER TestOwnershipChaining WITHOUT LOGIN;
GO

CREATE SCHEMA Demo;
GO
CREATE TABLE Demo.Sample (
SampleId INT IDENTITY (1,1) NOT NULL CONSTRAINT PKOwnershipChain PRIMARY KEY,
Value NVARCHAR(10) );
GO
INSERT INTO Demo.Sample (Value) VALUES ('Value');
GO 2 --runs this batch 2 times so we get two rows







--Permissions\Authorization\A demonstration of permissions with views, stored procedures, and functions\Test permissions using a view


/*
Execute this and all following code in this section while logged in as a member of the db_owner database role (or simply with your administrator login that is a member of the sysadmin role):
*/

CREATE VIEW Demo.SampleView 
AS
        SELECT Value AS ValueFromView 
        FROM Demo.Sample;
GO
GRANT SELECT ON Demo.SampleView TO TestOwnershipChaining;
GO

/*
The TestOwnershipChaining principal now has access to the view Demo.SampleView, but not to the Demo.Sample table. 
Now, attempt to read data from the table:
*/

EXECUTE AS USER = 'TestOwnershipChaining';
SELECT * FROM Demo.Sample;
REVERT;
GO


--But the user TestOwnershipChaining can still access the data in Demo.Sample via the view:

EXECUTE AS USER = 'TestOwnershipChaining';
SELECT * FROM Demo.SampleView;
REVERT;
GO





--Permissions\Authorization\A demonstration of permissions with views, stored procedures, and functions\Test permissions using a stored procedure


/*
Let’s demonstrate the same abstraction of permissions by using a stored procedure, and then also demonstrate a case when it fails. Start with creating the stored procedure object:
*/

CREATE PROCEDURE Demo.SampleProcedure AS
BEGIN
SELECT Value AS ValueFromProcedure
FROM Demo.Sample;
END
GO
GRANT EXECUTE ON Demo.SampleProcedure to TestOwnershipChaining;
GO


--Now try to run as our TestOwnershipChaining principal:

EXECUTE AS USER = 'TestOwnershipChaining';
EXEC Demo.SampleProcedure;
REVERT; 


/*
It works without any access to the Demo.Sample table. The user TestOwnershipChaining was able to access the data in the table due to ownership chaining.
Now, let’s break a stored procedure’s ability to abstract the permissions using dynamic SQL:
*/

CREATE PROCEDURE Demo.SampleProcedure_Dynamic AS
BEGIN
DECLARE @sql nvarchar(max)
SELECT @sql = 'SELECT Value as ValueFromProcedureDynamic
                            FROM Demo.Sample;';
EXEC sp_executesql @SQL;
END

--Then when you execute this version of the procedure:

EXECUTE AS USER = 'TestOwnershipChaining';
EXEC Demo.SampleProcedure;
REVERT;
GO


/*
In this case, we create a database principal named ElevatedRights and grant it select rights to Demo.Sample, then execute the code as that user.
*/


CREATE USER ElevatedRights WITHOUT LOGIN; 
GRANT SELECT ON OBJECT::Demo.Sample TO ElevatedRights;
GO
CREATE OR ALTER PROCEDURE Demo.SampleProcedure_Dynamic 
WITH EXECUTE AS 'ElevatedRights' 
AS
BEGIN
DECLARE @sql nvarchar(1000)
SELECT @sql = 'SELECT Value as ValueFromProcedureDynamic
               FROM Demo.Sample;';
EXEC sp_executesql @SQL;
END;
GO

GRANT EXECUTE ON OBJECT::Demo.SampleProcedure_Dynamic to TestOwnershipChaining;


--Now, executing the procedure, access to the data is possible and data is returned.


EXECUTE AS USER = 'TestOwnershipChaining';
EXEC Demo.SampleProcedure_Dynamic;
REVERT;


--Permissions\Authorization\A demonstration of permissions with views, stored procedures, and functions\Access a table even when SELECT is denied

/*
Let’s take it one step further and DENY SELECT permissions to TestOwnershipChaining. Will we still be able to access the underlying table data via a view and stored procedure?
*/

DENY SELECT ON Demo.Sample TO TestOwnershipChaining;
GO
EXECUTE AS USER = 'TestOwnershipChaining';
SELECT *
FROM   Demo.Sample;
GO
SELECT * FROM Demo.SampleView --test the view
GO
EXEC Demo.SampleProcedure; --test the stored procedure
GO
EXEC Demo.SampleProcedure_Dynamic; --test the stored procedure
GO
REVERT;
GO



