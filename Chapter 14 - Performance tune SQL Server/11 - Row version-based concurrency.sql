--The SNAPSHOT isolation level works at the transaction level. Once you start a transaction, and access any data in the transaction, such as the third statement in the following snippet:
ALTER DATABASE dbname SET ALLOW_SNAPSHOT_ISOLATION ON; -- required once
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
BEGIN TRANSACTION;
SELECT * FROM dbo.Table1;
--Don’t forget to COMMIT or ROLLBACK this transaction if you execute this code with a real table
