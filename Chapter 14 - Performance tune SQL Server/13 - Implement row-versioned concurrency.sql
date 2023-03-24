--Here's how to allow transactions in a database to start transactions in the SNAPSHOT isolation level:
ALTER DATABASE databasename SET ALLOW_SNAPSHOT_ISOLATION ON;
--After executing only the above statement, all transactions will continue to use the default READ COMMITTED isolation level, but you now can specify the use of SNAPSHOT isolation level at the session level or in table hints, as shown in the following example:
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
--Here's how to turn on RCSI:
ALTER DATABASE databasename SET READ_COMMITTED_SNAPSHOT ON;
