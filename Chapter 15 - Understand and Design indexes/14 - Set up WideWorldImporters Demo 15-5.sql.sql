--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

USE WideWorldImporters;
GO

-- Fill haystack with 3+ million rows
INSERT INTO Sales.InvoiceLines (
    InvoiceLineID
    , InvoiceID
    , StockItemID
    , Description
    , PackageTypeID
    , Quantity
    , UnitPrice
    , TaxRate
    , TaxAmount
    , LineProfit
    , ExtendedPrice
    , LastEditedBy
    , LastEditedWhen
    )
SELECT InvoiceLineID = NEXT VALUE
FOR [Sequences].[InvoiceLineID]
    , InvoiceID
    , StockItemID
    , Description
    , PackageTypeID
    , Quantity
    , UnitPrice
    , TaxRate
    , TaxAmount
    , LineProfit
    , ExtendedPrice
    , LastEditedBy
    , LastEditedWhen
FROM Sales.InvoiceLines;
GO 3 --Runs the above three times

-- Insert millions of records for InvoiceID 69776
INSERT INTO Sales.InvoiceLines (
    InvoiceLineID
    , InvoiceID
    , StockItemID
    , Description
    , PackageTypeID
    , Quantity
    , UnitPrice
    , TaxRate
    , TaxAmount
    , LineProfit
    , ExtendedPrice
    , LastEditedBy
    , LastEditedWhen
    )
SELECT InvoiceLineID = NEXT VALUE
FOR [Sequences].[InvoiceLineID]
    , 69776
    , StockItemID
    , Description
    , PackageTypeID
    , Quantity
    , UnitPrice
    , TaxRate
    , TaxAmount
    , LineProfit
    , ExtendedPrice
    , LastEditedBy
    , LastEditedWhen
FROM Sales.InvoiceLines;
GO

--Clear cache, drop other indexes to only test our comparison scenario
DBCC FREEPROCCACHE

DROP INDEX IF EXISTS [NCCX_Sales_InvoiceLines] ON [Sales].[InvoiceLines];
DROP INDEX IF EXISTS IDX_NC_InvoiceLines_InvoiceID_StockItemID_Quantity ON [Sales].[InvoiceLines];
DROP INDEX IF EXISTS IDX_CS_InvoiceLines_InvoiceID_StockItemID_Quantity ON [Sales].[InvoiceLines];
GO

--Create a rowstore nonclustered index for comparison
CREATE INDEX IDX_NC_InvoiceLines_InvoiceID_StockItemID_Quantity ON [Sales].[InvoiceLines] (
    InvoiceID
    , StockItemID
    , Quantity
    );
GO