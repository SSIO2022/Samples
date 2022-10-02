-- Certain datatypes are not supported. The sql_variant datatype is not currently supported by the DMS for online migrations to Azure SQL Database. To check your tables for this data type, run the following query:
SELECT DISTINCT c.TABLE_NAME,c.COLUMN_NAME,c.DATA_TYPE
FROM INFORMATION_SCHEMA.columns AS c
WHERE c.data_type in ('sql_variant');
