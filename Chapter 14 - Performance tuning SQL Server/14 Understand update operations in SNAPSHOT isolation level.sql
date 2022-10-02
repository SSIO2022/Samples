--For example, consider the following steps, with each transaction coming from a different session. In this example, Transaction 2 fails due to a concurrency conflict or “write-write error:”
--1.	A table contains multiple rows, each with a unique Type value.
CREATE TABLE Demo.SS_Update_Test
(Type int CONSTRAINT PKSS_Update_Test PRIMARY KEY,
 Value nvarchar(10));
INSERT INTO Demo.SS_Update_Test VALUES (0,'Zero'),(1,'One'),(2,'Two'),(3,'Three');
--2.	Transaction 1 begins a transaction in the READ COMMITTED isolation level and performs an update on the row where ID = 1.
--Transaction 1
BEGIN TRANSACTION ;
UPDATE Demo.SS_Update_Test
SET  Value = 'Won'
WHERE Type = 1;
--3.	Transaction 2 sets its session isolation level to SNAPSHOT and issues a statement to update the row where ID = 1, this connection is blocked, waiting on the modification locks to clear.
--Transaction 2
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
BEGIN TRANSACTION
UPDATE Demo.SS_Update_Test
SET  Value = 'Wun'
WHERE Type = 1;
-- 4.	Transaction 1 commits, using a COMMIT TRANSACTION statement. The update succeeds.
-- 5.	Transaction 2 then immediately fails with SQL error 3960.
-- Msg 3960, Level 16, State 2, Line 8
-- Snapshot isolation transaction aborted due to update conflict. You cannot use snapshot isolation to access table 'dbo.AnyTable' directly or indirectly in database 'DatabaseName' to update, delete, or insert the row that has been modified or deleted by another transaction. Retry the transaction or change the isolation level for the update/delete statement.
