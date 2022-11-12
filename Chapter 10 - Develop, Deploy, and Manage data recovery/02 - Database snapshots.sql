--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

-- To create a database snapshot, you create a special database snapshot file, commonly with the extension .ss. 
-- For example, to create a database snapshot of the WideWorldImporters database as the iso date and time November 2, 2022 at 10:45AM:
CREATE DATABASE [WideWorldImporters_202211021045] ON  
( NAME = WideWorldImporters, FILENAME = 
'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Data\WideWorldImporters_data_202211021045.ss' )  
AS SNAPSHOT OF [WideWorldImporters];

--To revert the entire WideWorldImporters to the database snapshot, the T-SQL command is simple:
RESTORE DATABASE [WideWorldImporters] FROM
DATABASE_SNAPSHOT = ' WideWorldImporters_202211021045';
