--Queries are captured in the context of the database where the query is executed. In the following cross-database query example, the query's execution is captured in the Query Store of the WideWorldImporters database.
USE WideWorldImporters;
GO
SELECT * FROM
AdventureWorks.[Purchasing].[PurchaseOrders];

--You can turn on Query Store via the database Properties dialog box, in which Query Store is a page on the menu on the left. Or, you can turn it on via T-SQL by using the following command:
ALTER DATABASE [DatabaseOne] SET QUERY_STORE = ON;
