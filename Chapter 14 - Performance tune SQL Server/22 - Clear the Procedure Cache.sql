--You can also remove a single plan from cache by identifying its plan_handle and then providing it as the parameter to the ALTER DATABASE statement. Perhaps this is a plan you would like to remove for testing or troubleshooting purposes that you have identified with the script in the previous section:
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE 0x06000700CA920912307B867DB701000001000000000000000000000000000000000000000000000000000000;
--You can alternatively flush the cache by object type. This command clears cached execution plans that are the result of ad hoc statements and prepared statements (from applications, using sp_prepare, typically through an API):
DBCC FREESYSTEMCACHE ('SQL Plans');
--The advantage of this statement is that it does not wipe the cached plans from “Programmability” database objects such as stored procedures, multi-statement table-valued functions, scalar user-defined functions, and triggers. The following command clears the cached plans from those type of objects:
DBCC FREESYSTEMCACHE ('Object Plans');
--Note that DBCC FREESYSTEMCACHE is not supported in Azure SQL Database.
--You can also use DBCC FREESYSTEMCACHE to clear cached plans association to a specific Resource Governor Pool, as follows:
DBCC FREESYSTEMCACHE ('SQL Plans', 'poolname');
