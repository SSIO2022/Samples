--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

UPDATE STATISTICS [Purchasing].[SupplierTransactions] 
    [CX_Purchasing_SupplierTransactions] WITH RESAMPLE ON PARTITIONS (1);