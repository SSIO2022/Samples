--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 15
--


-- Create database scoped credential
IF NOT EXISTS(SELECT * FROM sys.credentials WHERE name = 'sqlserver2022parquets3')
BEGIN
 CREATE DATABASE SCOPED CREDENTIAL sqlserver2022parquets3 --PolyBaseS3
 WITH IDENTITY = 'S3 Access Key',
 SECRET = '######';
END

-- Create external source
-- Can use URL not just IP address
CREATE EXTERNAL DATA SOURCE sqlserver2022parquetdc
WITH
(
    LOCATION = 's3://sqlserver2022parquet.s3.us-east-1.amazonaws.com/',
    CREDENTIAL = sqlserver2022parquets3
);

-- Create external file format
CREATE EXTERNAL FILE FORMAT ParquetFileFormat WITH (FORMAT_TYPE = PARQUET);
GO

-- Create external table
-- Location below specifies folder and filename
CREATE EXTERNAL TABLE Warehouse.ColdRoomTemperaturesParquet (
    [ColdRoomTemperatureID] [bigint] ,
    [ColdRoomSensorNumber] [int] ,
    [RecordedWhen] [datetime2](7) ,
    [Temperature] [decimal](10, 2) ,
    [ValidFrom] [datetime2](7) ,
    [ValidTo] [datetime2](7)  )
WITH (LOCATION = '/output/ColdRoomTemperatures.parquet', DATA_SOURCE = sqlserver2022parquetdc, 
FILE_FORMAT = ParquetFileFormat);
GO

-- Query data directly from S3 storage with OPENROWSET
SELECT  TOP 1 * 
FROM    OPENROWSET
        (   BULK 'output/ColdRoomTemperatures.parquet',
            FORMAT       = 'PARQUET',
            DATA_SOURCE  = 'sqlserver2022parquetdc'
        ) AS [cc];

-- Can query the external table directly as well
SELECT  TOP 1 *
FROM Warehouse.ColdRoomTemperaturesParquet;
