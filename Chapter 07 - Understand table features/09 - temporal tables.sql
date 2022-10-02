--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 9
--

-- Use your own sample database for the CREATE TABLE statement
CREATE TABLE dbo.Products (
    -- Clustered primary key is required
    ProductId int NOT NULL PRIMARY KEY CLUSTERED
  , ProductName varchar(50) NOT NULL
  , CategoryId int NOT NULL
  , SalesPrice money NOT NULL
  , SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
  , SysEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
  -- PERIOD FOR SYSTEM_TIME to indicate columns storing validity start and end
  , PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime))
-- SYSTEM_VERSIONING clause without HISTORY_TABLE option creates
-- an anonymous history table, meaning the name will be auto-generated
WITH (SYSTEM_VERSIONING = ON);

USE WideWorldImporters;
GO

-- ALL creates a union between the history and the current table
SELECT PersonID, FullName,
      CASE WHEN ValidTo = ‘9999-12-31 23:59:59.9999999’ THEN 1
         ELSE 0 END AS IsCurrent
FROM Application.People FOR SYSTEM_TIME ALL
WHERE PeriodId = 11
ORDER BY ValidFrom;

/* AS OF sub-clause returns all rows that were valid at one point in time.
 * Recall the SYSTEM_TIME is UTC.
 * Showing an example here of how to convert a local time to UTC:
 * Local time is March 13, 2016 12:00 AM (midnight) US Pacific Time
 * (the start of the day).
 * March 13 is not in daylight saving time, so the offset is -8 hours.
 * Thus, records we’re looking for were active on March 13, 2016 8 AM UTC.
 * Calling the AT TIME ZONE function twice gives the desired time in UTC.
 */
DECLARE @AsOfTime datetime2(7) = CONVERT(datetime2(7), ‘2016-03-13T00:00:00’, 126)
    AT TIME ZONE ‘Pacific Standard Time’ AT TIME ZONE ‘UTC’;
SELECT PersonID, FullName
    , CASE WHEN ValidTo = ‘9999-12-31 23:59:59.9999999’ THEN 1
           ELSE 0 END ‘IsCurrent’
FROM [Application].People FOR SYSTEM_TIME AS OF @AsOfTime
ORDER BY ValidFrom;

-- FROM ... TO returns all rows that were at least partially valid
-- in the specified time frame, excluding the actual start and end time
SELECT PersonID, FullName,
     CASE WHEN ValidTo = ‘9999-12-31 23:59:59.9999999’ THEN 1
         ELSE 0 END AS IsCurrent
-- SYSTEM_TIME uses UTC so provide date range in UTC as well
FROM Application.People FOR SYSTEM_TIME FROM ‘2016-03-13’ TO ‘2016-04-23’ORDER BY ValidFrom;

-- BETWEEN ... AND returns all rows that were at least partially valid
-- in the specified time frame, including rows whose validity started
-- exactly at the upper bound. Rows whose validity ended exactly
-- on the lower bound are excluded, just like in FROM ... TO
SELECT PersonID, FullName,
     CASE WHEN ValidTo = ‘9999-12-31 23:59:59.9999999’ THEN 1
         ELSE 0 END AS IsCurrent
FROM Application.People FOR SYSTEM_TIME BETWEEN ‘2016-03-13’ AND ‘2016-04-23’
ORDER BY ValidFrom;

-- CONTAINED IN returns all rows that were exclusively valid inside
-- the given time frame
DECLARE @now datetime2(7) = SYSUTCDATETIME();
SELECT PersonID, FullName,
     CASE WHEN ValidTo = '9999-12-31 23:59:59.9999999' THEN 1
         ELSE 0 END AS IsCurrent
FROM Application.People FOR SYSTEM_TIME CONTAINED IN ('2016-03-13', @now)
ORDER BY ValidFrom;
