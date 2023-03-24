--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################
--
-- CHAPTER 7: UNDERSTAND TABLE FEATURES
-- T-SQL SAMPLE 14
--


-- Create a Master Key
   CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'password';
   CREATE DATABASE SCOPED CREDENTIAL credential_name
   WITH IDENTITY = 'username', Secret = 'password';

-- LOCATION: Location string for data
   CREATE EXTERNAL DATA SOURCE external_data_source_name
   WITH ( LOCATION = 'oracle://<server address>[:<port>]',   CREDENTIAL = credential_name);

--Create table
   CREATE EXTERNAL TABLE customers(
   [O_ORDERKEY] DECIMAL(38) NOT NULL,
   [O_CUSTKEY] DECIMAL(38) NOT NULL,
   [O_ORDERSTATUS] CHAR COLLATE Latin1_General_BIN NOT NULL,
   [O_TOTALPRICE] DECIMAL(15,2) NOT NULL,
   [O_ORDERDATE] DATETIME2(0) NOT NULL,
   [O_ORDERPRIORITY] CHAR(15) COLLATE Latin1_General_BIN NOT NULL,
   [O_CLERK] CHAR(15) COLLATE Latin1_General_BIN NOT NULL,
   [O_SHIPPRIORITY] DECIMAL(38) NOT NULL,
   [O_COMMENT] VARCHAR(79) COLLATE Latin1_General_BIN NOT NULL
   )
   WITH ( LOCATION='customer', DATA_SOURCE= external_data_source_name   );
