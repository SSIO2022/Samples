--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

--Example usage: (last resort only, not recommended!) 

ALTER DATABASE WorldWideImporters SET EMERGENCY, SINGLE_USER; 

DBCC CHECKDB('WideWorldImporters', REPAIR_ALLOW_DATA_LOSS); 

ALTER DATABASE WorldWideImporters SET MULTI_USER; 
