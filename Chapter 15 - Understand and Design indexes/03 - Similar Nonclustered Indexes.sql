--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

CREATE INDEX IDX_NC_InvoiceLines_InvoiceID_StockItemID
ON [Sales].[InvoiceLines] (InvoiceID, StockItemID);

CREATE INDEX IDX_NC_InvoiceLines_StockItemID_InvoiceID
ON [Sales].[InvoiceLines] (StockItemID, InvoiceID);
