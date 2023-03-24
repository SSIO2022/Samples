--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

SELECT name, temporal_type, temporal_type_desc
FROM sys.tables
WHERE temporal_type <> 0;
