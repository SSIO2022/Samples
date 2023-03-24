--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

ALTER INDEX PK_table1 ON dbo.table1
SET (OPTIMIZE_FOR_SEQUENTIAL_KEY = ON);