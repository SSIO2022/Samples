-- SQL Server 2022 Administration Inside Out (Chapter 13)
-- This is a sample script that accompanies the above title.
--
-- Create a server audit and set it active.

USE master;
GO

-- Create the server audit.
CREATE SERVER AUDIT Sales_Security_Audit
    TO FILE (FILEPATH = 'C:\SalesAudit');
GO  

-- Enable the server audit.
ALTER SERVER AUDIT Sales_Security_Audit
    WITH (STATE = ON);
GO
