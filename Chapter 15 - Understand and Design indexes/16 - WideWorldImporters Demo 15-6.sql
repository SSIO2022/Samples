--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

--Create a columnstore nonclustered index for comparison
CREATE COLUMNSTORE INDEX IDX_CS_InvoiceLines_InvoiceID_StockItemID_quantity
    ON [Sales].[InvoiceLines] (InvoiceID, StockItemID, Quantity)
    WITH (ONLINE = ON);
GO

SET STATISTICS TIME ON;

--Run the same query as before, but now it will use the columnstore
SELECT il.StockItemID, AvgQuantity = AVG(il.quantity)
FROM [Sales].[InvoiceLines] AS il
WHERE il.InvoiceID = 69776 --1.8 million records
GROUP BY il.StockItemID;

SET STATISTICS TIME OFF;