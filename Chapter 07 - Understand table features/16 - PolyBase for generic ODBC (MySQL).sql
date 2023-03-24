--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 16
--

-- Create database scoped credential
IF NOT EXISTS(SELECT * FROM sys.credentials WHERE name = 'sqlserver2022mysql')
BEGIN
 CREATE DATABASE SCOPED CREDENTIAL sqlserver2022mysql
 WITH IDENTITY = 'sqlzelda',
 SECRET = '<Strong Password>';
END

-- Create external source
CREATE EXTERNAL DATA SOURCE sqlserver2022mysqldc
WITH ( LOCATION = 'odbc://localhost:3306',
CONNECTION_OPTIONS = 'Driver={MySQL ODBC 8.0 ANSI Driver};
ServerNode = localhost:3306',
--PUSHDOWN = ON,
CREDENTIAL = sqlserver2022mysql );

-- Create external table
-- Location below specifies folder and filename
CREATE EXTERNAL TABLE Warehouse.ColdRoomTemperatureMySQL
(
	ColdRoomTemperatureID INT NOT NULL,
	ColdRoomSensorNumber INT NOT NULL,
	Temperature DECIMAL(10, 2) NOT NULL--,
)
 WITH 
 (
    LOCATION='coldroom.coldroomtemperatures',
    DATA_SOURCE = sqlserver2022mysqldc
 );
GO

-- Add index to external table
CREATE STATISTICS stx_coldroomsensornumber 
	ON Warehouse.ColdRoomTemperatureMySQL (ColdRoomSensorNumber) 
	WITH FULLSCAN;

-- Can query the external table directly as well
SELECT TOP 1 ColdRoomTemperatureID;
