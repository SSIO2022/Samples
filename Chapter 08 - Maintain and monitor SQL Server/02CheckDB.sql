--Example usage: (last resort only, not recommended!) 

ALTER DATABASE WorldWideImporters SET EMERGENCY, SINGLE_USER; 

DBCC CHECKDB(‘WideWorldImporters’, REPAIR_ALLOW_DATA_LOSS); 

ALTER DATABASE WorldWideImporters SET MULTI_USER; 
