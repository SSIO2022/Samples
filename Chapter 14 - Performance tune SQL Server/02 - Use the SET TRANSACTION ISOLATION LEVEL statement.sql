--You can change the isolation level of a connection any time, even when already executing in the context of a transaction that is uncommitted. 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRAN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
--SELECT...;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
COMMIT TRAN;

--This code snippet is trying to change from READ COMMITTED to the SNAPSHOT isolation level:
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRAN;
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
--SELECT...

--For example, you might have seen developers use NOLOCK at the end of a table, effectively (and dangerously) dropping access to that table into the READ UNCOMMITTED isolation level:
SELECT col1 FROM dbo.Table (NOLOCK);

--Aside from the inadvisable use of NOLOCK in the preceding example, using a table hint without WITH is deprecated syntax (since SQL Server 2008). It should be written like this, if you needed to ignore locks:
SELECT col1 FROM dbo.TableName WITH (READUNCOMMITTED);
