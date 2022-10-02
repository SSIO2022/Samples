-- SQL Server 2022 Administration Inside Out (Chapter 13)
-- This is a sample script that accompanies the above title.
--
-- Back up the SMK to the local hard drive.

BACKUP SERVICE MASTER KEY TO FILE = 'c:\SecureLocation\service_master_key'   
   ENCRYPTION BY PASSWORD = '<UseAReallyStrongPassword>';  
GO
