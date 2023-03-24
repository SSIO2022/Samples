/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

-- Back up the SMK to the local hard drive.
BACKUP SERVICE MASTER KEY TO FILE = 'c:\SecureLocation\service_master_key'   
   ENCRYPTION BY PASSWORD = '<UseAReallyStrongPassword>';  
GO
