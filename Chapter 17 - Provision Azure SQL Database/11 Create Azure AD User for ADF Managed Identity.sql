--Creates AAD user in database for an Azure Data Factory Managed Identity named MyFactory 
--The Display name for a system-assigned managed identity is the name of the data factory 

CREATE USER [MyFactory] FROM EXTERNAL PROVIDER;
