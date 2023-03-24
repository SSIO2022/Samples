INSERT INTO dbo.testnolock1 WITH (NOLOCK)
SELECT * FROM dbo.testnolock2;
-- SQL Server knows that it will use locks for the INSERT, and makes it clear by way of the following error being thrown:
-- Msg 1065, Level 15, State 1, Line 17
-- The NOLOCK and READUNCOMMITTED lock hints are not allowed for target tables of INSERT, UPDATE, DELETE or MERGE statements.
-- However, this protection doesn't apply to the source of any writes, hence yet another danger. This following code is allowed and is very dangerous because it could write invalid, uncommitted data!
INSERT INTO testnolock1
SELECT * FROM testnolock2 WITH (NOLOCK);
-- In summary, don't use READ COMMITTED isolation level or NOLOCK unless you really understand the implications of reading dirty data and have an ironclad reason for doing so. For example, it is an invaluable tool as a DBA to be able to see the changes to data being made in another connection. For example,
SELECT COUNT(*) FROM dbo.TableName WITH (NOLOCK); 
-- Allows you to see the count of rows in dbo.TableName. 
