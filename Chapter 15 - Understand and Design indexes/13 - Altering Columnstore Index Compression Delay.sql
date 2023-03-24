--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

ALTER INDEX [NCCX_Sales_InvoiceLines]
    ON [Sales].[InvoiceLines]
    SET (COMPRESSION_DELAY = 10 MINUTES);