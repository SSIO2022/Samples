--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

/* Original query for Wide World Importers (accompanies Figures 15-1 & 15-2) */
SELECT CustomerID, AccountsPersonID
FROM [Sales].[Invoices]
WHERE CustomerID = 832;
GO

/* Add nonclustered index on CustomerID */
CREATE NONCLUSTERED INDEX [FK_Sales_Invoices_CustomerID]
ON [Sales].[Invoices] (CustomerID ASC)
ON [USERDATA];
GO

/* 
    Adding nonclustered index on CustomerID with included AccountsPersonID column 

    Rerun the original query to get a new query plan (Figure 15-3)
*/
CREATE NONCLUSTERED INDEX [FK_Sales_Invoices_CustomerID]
ON [Sales].[Invoices] (CustomerID ASC) INCLUDE (AccountsPersonID)
    WITH (DROP_EXISTING = ON)
ON [USERDATA];
GO
