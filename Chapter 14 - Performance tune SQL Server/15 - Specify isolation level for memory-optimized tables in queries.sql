--If you are in the context of a transaction, it will not automatically default to SNAPSHOT isolation level. Rather you need to specify the isolation level as a hint, such as:
BEGIN TRANSACTION;
SELECT *
FROM   dbo.MemoryOptimizedTable WITH (SNAPSHOT);
