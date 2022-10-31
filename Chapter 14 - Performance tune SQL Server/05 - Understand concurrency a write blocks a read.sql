--In this scenario, an uncommitted write in Transaction 1 blocks a read in Transaction 2. The transactions are explicitly started using the BEGIN/COMMIT TRANSACTION syntax. In this example, the transactions are not overriding the default isolation level of READ COMMITTED:
--1.	A table with a column Type contains only two rows, values of 0 and 1.
CREATE SCHEMA Demo AUTHORIZATION dbo;
CREATE TABLE Demo.RC_Test_Write_V_Read (Type int);
INSERT INTO Demo.RC_Test_Write_V_Read VALUES (0),(1);
--2.	Transaction 1 begins and updates rows with Type = 1 to Type = 2.
--Transaction 1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;
UPDATE Demo.RC_Test_Write_V_Read SET Type = 2
WHERE  Type = 1;
--Note that Transaction 1 has not committed or rolled back.
--3.	Before Transaction 1 commits, in another session, Transaction 2 begins and issues a SELECT statement for rows WHERE Type = 2. Transaction 2 is blocked and waits for Transaction 1 to commit.
--Transaction 2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT Type
FROM   Demo.RC_Test_Write_V_Read
WHERE  Type = 2;
--4.	Transaction 1 commits.
--Transaction 1
COMMIT;
--5.	Transaction 2 is no longer blocked and processes its SELECT statement.
