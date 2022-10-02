--In this scenario, we protect Transaction 1 from a phantom read.
--1.	A table contains two rows with Type values 0 and 1
CREATE TABLE Demo.PR_Test_Prevent (Type int);
INSERT INTO Demo.PR_Test_Prevent VALUES (0),(1);
--2.	Transaction 1 starts and selects rows where Type = 1 in the SERIALIZABLE isolation level. The one row where Type = 1 is returned.
--Transaction 1
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;
SELECT Type
FROM   Demo.PR_Test_Prevent
WHERE  Type = 1;
--3.	Before Transaction 1 commits, Transaction 2 starts and issues an INSERT statement, adding a row of Type = 1. Transaction 2 is blocked by Transaction 1.
--Transaction 2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
INSERT INTO Demo.PR_Test_Prevent(Type)
VALUES(1);
--4.	Transaction 1 again selects rows where Type = 1. The same result set is returned as it was in step 2, the one row where Type = 1.
--Transaction 1
SELECT Type
FROM   Demo.PR_Test_Prevent
WHERE  Type = 1;
--5.	Transaction 1 executes COMMIT TRANSACTION.
--Transaction 1
COMMIT TRANSACTION;

