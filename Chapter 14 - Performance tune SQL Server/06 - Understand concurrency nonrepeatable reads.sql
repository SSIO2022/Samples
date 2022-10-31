--In this scenario, Transaction 1 will suffer a nonrepeatable read when it reads rows that are changed by a different connection, as the default READ COMMITTED does not offer any protection against phantom or nonrepeatable reads.
--1.	A table contains only two rows with a column Type value of 0 and 1.
CREATE TABLE Demo.RR_Test (Type int);
INSERT INTO Demo.RR_Test VALUES (0),(1);
--2.	Transaction 1 starts and retrieves rows where Type = 1. One row is returned for Type = 1.
--Transaction 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
SELECT Type
FROM   Demo.RR_Test
WHERE  Type = 1;
--3.	Before Transaction 1 commits, Transaction 2 starts and issues an UPDATE statement, setting rows of Type = 1 to Type = 2. Transaction 2 is not blocked and is immediately processed.
--Transaction 2
BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
UPDATE Demo.RR_Test
SET  Type = 2
WHERE Type = 1;
--4.	Transaction 1 again selects rows where Type = 1 and is blocked.
--Transaction 1
SELECT Type
FROM   Demo.RR_Test
WHERE  Type = 1;
--5.	Transaction 2 commits.
--Transaction 2
COMMIT;
--6.	Transaction 1 is immediately unblocked. No rows are returned, since no committed rows now exist where Type = 1. Transaction 1 commits.
--Transaction 1
COMMIT;
