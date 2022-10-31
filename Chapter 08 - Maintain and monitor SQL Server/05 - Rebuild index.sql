--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

ALTER INDEX FK_Sales_Orders_CustomerID 
ON Sales.Orders 
REBUILD WITH (ONLINE = ON); 

--Rebuild All Indexes on table
ALTER INDEX ALL
ON [Sales].[OrderLines]
REBUILD; 
