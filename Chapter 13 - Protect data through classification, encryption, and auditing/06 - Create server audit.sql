/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

-- Create a server audit and set it active.
USE [master];
GO

-- Create the server audit.
CREATE SERVER AUDIT [Sales_Security_Audit]
    TO FILE (FILEPATH = 'C:\SalesAudit');
GO  

-- Enable the server audit.
ALTER SERVER AUDIT [Sales_Security_Audit]
    WITH (STATE = ON);
GO
