--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

SELECT *
FROM sys.dm_db_index_physical_stats(
    DB_ID(),
    object_id('Sales.Invoices'),
    NULL,
    NULL,
    'DETAILED'
);