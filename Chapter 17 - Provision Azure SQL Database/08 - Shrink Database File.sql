--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

-- Shrink database named Contoso
DBCC SHRINKDATABASE ('Contoso');
-- Be sure to rebuild all indexes afterwards!
