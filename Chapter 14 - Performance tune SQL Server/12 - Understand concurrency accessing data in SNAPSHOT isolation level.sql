--In this scenario, we see that Transaction 2 has access to previously committed row data, even though those rows are being updated concurrently.
--1.	A table contains only rows with a column Type value of 0 and 1.
CREATE TABLE Demo.SS_Test (Type int);
INSERT INTO Demo.SS_Test VALUES (0),(1);
--2.	Transaction 1 starts and updates rows where Type = 1 to Type = 2.
--Transaction 1
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION READ COMMITTED;
UPDATE Demo.SS_Test
SET  Type = 2
WHERE Type = 1;
--3.	Before Transaction 1 commits, Transaction 2 sets its session isolation level to SNAPSHOT and executes BEGIN TRANSACTION.
--Transaction 2
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
BEGIN TRANSACTION;
--4.	Transaction 2 issues a SELECT statement WHERE Type = 1. Transaction 2 is not blocked by Transaction 1. A row where Type = 1 is returned.
--Transaction 2
SELECT Type
FROM   Demo.SS_Test
WHERE  Type = 1;
-- 5.	Transaction 1 executes a COMMIT TRANSACTION.
-- 6.	Transaction 2 again issues a SELECT statement WHERE Type = 1. The same rows from step 3 are returned. 