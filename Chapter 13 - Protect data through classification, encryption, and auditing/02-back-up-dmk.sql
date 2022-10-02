-- SQL Server 2022 Administration Inside Out (Chapter 13)
-- This is a sample script that accompanies the above title.
--
-- Back up the DMK for the WideWorldImporters database.

USE WideWorldImporters;
GO
BACKUP MASTER KEY TO FILE = 'c:\SecureLocation\wwi_database_master_key'
    ENCRYPTION BY PASSWORD = '<UseAReallyStrongPassword>';
GO  
