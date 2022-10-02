--2.	Use sys.sp_query_store_set_hints to apply a hint. Most query hints are supported. For a complete list, review the Microsoft Docs article for sys.sp_query_store_set_hints at https://docs.microsoft.com/sql/relational-databases/system-stored-procedures/sys-sp-query-store-set-hints-transact-sql#supported-query-hints. 
--For example, to apply the MAXDOP 1 hint to query_id 1234:
EXEC sys.sp_query_store_set_hints @query_id= 1234, @query_hints = N'OPTION(MAXDOP 1)';
--You can specify more than one query hint in a Query Store hint, just as you would in the OPTION clause of any T-SQL query. For example, to specify MAXDOP 1 and the pre-SQL 2014 cardinality estimator:
EXEC sys.sp_query_store_set_hints @query_id= 1234, 
@query_hints = N'OPTION(MAXDOP 1, 
USE HINT(''FORCE_LEGACY_CARDINALITY_ESTIMATION''))';
--The Query Store hint takes effect immediately and adds three attributes to the execution plan XML: QueryStoreStatementHintId, QueryStoreStatementHintText, and QueryStoreStatementHintSource. If you're curious, you can review these to see the Query Store hint in action and prove the hint altered the query without any code changes.
--3.	Observe and confirm your hint is helping. View the Query Store hint currently in place for your query:
SELECT * FROM sys.query_store_query_hints 
WHERE query_id = 1234;
--4.	And finally (prepare this ahead of time), remove the Query Store hint when necessary with sys.sp_query_store_clear_hints.
EXEC sys.sp_query_store_clear_hints @query_id = 1234;
--5.	Set yourself a reminder to reevaluate any Query Store hints on a regular basis. 