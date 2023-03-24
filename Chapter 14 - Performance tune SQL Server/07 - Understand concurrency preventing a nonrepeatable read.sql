--Consider the following steps involving a read and a write, with each transaction coming from a different session. This time, we protect Transaction 1 from dirty reads and nonrepeatable reads by using the REPEATABLE READ isolation level. A read in the REPEATABLE READ isolation level will block a write. The transactions are explicitly declared by using the BEGIN/COMMIT TRANSACTION syntax:
--1.	A table contains only rows with a column Type value of 0 and 1.
CREATE TABLE Demo.RR_Test_Prevent (Type int);
INSERT INTO Demo.RR_Test_Prevent VALUES (0),(1);
--2.	Transaction 1 starts and selects rows where Type = 1 in the REPEATABLE READ isolation level. 1 row with Type = 1 is returned.
--Transaction 1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRANSACTION;
SELECT Type
FROM   Demo.RR_Test_Prevent
WHERE  TYPE = 1;
--3.	Before Transaction 1 commits, Transaction 2 starts and issues an UPDATE statement, setting rows of Type = 1 to Type = 2. Transaction 2 is blocked by Transaction 1.
--Transaction 2
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE Demo.RR_Test_Prevent
SET  Type = 2
WHERE Type = 1;
--4.	Transaction 1 again selects rows where Type = 1. The same rows are returned as in step 2.
--5.	Transaction 1 commits.
--Transaction 1
COMMIT TRANSACTION;
--6.	Transaction 2 is immediately unblocked and processes its update. Transaction 2 commits.
--Transaction 2
COMMIT TRANSACTION;
