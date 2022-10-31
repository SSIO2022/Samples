--Consider the following steps involving a read and a write, with each transaction coming from a different session. In this scenario, we describe a phantom read:
--1.	A table contains only two rows, with Type values 0 and 1.
CREATE TABLE Demo.PR_Test (Type int);
INSERT INTO Demo.PR_Test VALUES (0),(1);
--2.	Transaction 1 starts and selects rows where Type = 1 in the REPEATABLE READ isolation level. Rows are returned.
--Transaction 1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRANSACTION;
SELECT Type
FROM   Demo.PR_Test
WHERE  Type = 1;
--3.	Before Transaction 1 commits, Transaction 2 starts and issues an INSERT statement, adding another row where Type = 1. Transaction 2 is not blocked by Transaction 1.
--Transaction 2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
INSERT INTO Demo.PR_Test(Type)
VALUES(1);
--4.	Transaction 1 again selects rows where Type = 1. An additional row is returned compared to the first time the select was run in Transaction 1.
--Transaction 1
SELECT Type
FROM   Demo.PR_Test
WHERE  Type = 1;
--5.	Transaction 1 commits.
--Transaction 1
COMMIT TRANSACTION;
