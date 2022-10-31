--To control which cardinality estimator is used, there are a few methods. The first is to use the database's compatibility level, like this command to use the SQL Server 2022 cardinality estimator:
ALTER DATABASE [db_name] SET COMPATIBILITY_LEVEL = 160;
--Or, backwards to the SQL Server 2014 compatibility level:
ALTER DATABASE [db_name] SET COMPATIBILITY_LEVEL = 120;
--Changing the database's compatibility level is often an unnecessary or drastic change. In your testing, consider reverting only to use the legacy cardinality estimator (which pre-dated SQL Server 2014):
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = ON;
--Here also, reverting to the legacy cardinality estimator can be too drastic a change for the entire database. In compatibility level 130 (SQL Server 2016) and higher, there is a query hint you can use to modify an individual query to use legacy cardinality estimation (CE version 70):
SELECT …
FROM …
OPTION (USE HINT ('FORCE_LEGACY_CARDINALITY_ESTIMATION'));
--What if you cannot modify the query to use the OPTION syntax, because it resides deep within a business intelligence suite, an ETL tool, or third-party software? SQL Server 2022 has a solution for you: identify the query in Query Store metadata and then provide a Query Store hint, shaping the query without altering any code. For example:
EXEC sys.sp_query_store_set_hints @query_id= 555, @query_hints = N'OPTION(USE HINT(''FORCE_LEGACY_CARDINALITY_ESTIMATION''))';
