--Example of scalar UDF inlining
--To demonstrate UDF inlining, we create the following overly simple UDF in WideWorldImporters:
USE WideWorldImporters;
GO
CREATE SCHEMA Tools;
GO
CREATE FUNCTION Tools.Bit_Translate
(@value bit)
RETURNS varchar(5)
AS
BEGIN
     RETURN (CASE WHEN @value = 1 THEN 'True' ELSE 'False' END);
END;
--To demonstrate, execute the function in the same query twice: once in SQL Server 2017 (140) database compatibility level, before scalar UDF inlining was introduced, and again with SQL Server 2022 (160) database compatibility level behavior.
SET STATISTICS TIME ON;
ALTER DATABASE WideWorldImporters SET COMPATIBILITY_LEVEL = 140; --SQL Server 2017
GO
SELECT Tools.Bit_Translate(IsCompressed) AS CompressedFlag,
CASE WHEN IsCompressed = 1 THEN 'True' ELSE 'False' END AS CompressedFlag_Desc
FROM  Warehouse.VehicleTemperatures;
GO
ALTER DATABASE WideWorldImporters SET COMPATIBILITY_LEVEL = 160; -- SQL Server 2022
GO
SELECT Tools.Bit_Translate(IsCompressed) AS CompressedFlag,
CASE WHEN IsCompressed = 1 THEN 'True' ELSE 'False' END
FROM   Warehouse.VehicleTemperatures;
