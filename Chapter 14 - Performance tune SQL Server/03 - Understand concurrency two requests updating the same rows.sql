--All examples will have these two rows simply so it isn't just a single row, though we will only manipulate the row where Type = 1. When testing more complex concurrency scenarios, it is best to have large quantities of data to work with as indexing, server resources, etc. do come into play. These examples illustrate simple, fundamental concurrency examples.
--1.	A table contains only two rows with a column Type containing values of 0 and 1.
CREATE SCHEMA Demo;
GO
CREATE TABLE Demo.RC_Test (Type int);
INSERT INTO Demo.RC_Test VALUES (0),(1);
--2.	Transaction 1 begins and updates all rows from Type = 1 to Type = 2.
--Transaction 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;
UPDATE Demo.RC_Test SET Type = 2
WHERE  Type = 1;
--3.	Before Transaction 1 commits, Transaction 2 begins and issues a statement to update Type = 2 to Type = 3. Transaction 2 is blocked and will wait for Transaction 1 to commit.
--Transaction 2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE Demo.RC_Test SET Type = 3
WHERE  Type = 2;
--4.	Transaction 1 commits.
--Transaction 1
COMMIT;
--5.	Transaction 2 is no longer blocked and processes its update statement. Transaction 2 then commits.
