--For example, a query may have values that could take on multiple values. A query such as:
SELECT Value From TableName WHERE Value = 'X';
--A simple query such as this can be parameterized and the literal 'X' replaced by a parameter, much like if you were writing a stored procedure. By default, a query where you reference more than one table will not be parameterized, but you can change the database setting of PARAMETERIZATION to FORCED and more complex queries will be parameterized. Finally, you can get a parameterized plan by using a variable:
DECLARE @Value varchar(10) = 'X';
SELECT Value From TableName WHERE Value = @Value;
--For example, you might create the following stored procedure to fetch the orders that have been placed for goods from a certain supplier:
CREATE OR ALTER PROCEDURE Purchasing.PurchaseOrders_BySupplierId
      @SupplierId int
AS
SELECT PurchaseOrders.PurchaseOrderID,
       PurchaseOrders.SupplierID,
       PurchaseOrders.OrderDate
 FROM   Purchasing.PurchaseOrders
WHERE  PurchaseOrders.SupplierID = @SupplierId;
--In case you are troubleshooting competing plan guides and Query Store forced plans, you can view any existing plan guides and forced query plans with the following queries of the system catalog:
SELECT * FROM sys.plan_guides;
SELECT *
FROM sys.query_store_query AS qsq
INNER JOIN sys.query_store_plan AS qsp
     ON qsp.query_id = qsq.query_id
WHERE qsp.is_forced_plan = 1;
