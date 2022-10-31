-- SQL Server 2022 Administration Inside Out (Chapter 13)
-- This is a sample script that accompanies the above title.
--
-- Create a database audit specification and set it active.

USE WideWorldImporters;
GO

-- Create the database audit specification.
CREATE DATABASE AUDIT SPECIFICATION Sales_Tables
    FOR SERVER AUDIT Sales_Security_Audit
    ADD (SELECT, INSERT ON Sales.CustomerTransactions BY dbo)   
    WITH (STATE = ON);
GO
