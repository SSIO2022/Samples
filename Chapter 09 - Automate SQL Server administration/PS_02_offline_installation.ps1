################################################################################
##
## SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
##
## © 2022 MICROSOFT PRESS
##
################################################################################
##
## CHAPTER 9: AUTOMATE SQL SERVER ADMINISTRATION
## POWERSHELL SAMPLE 2

#On an online machine:
Save-Module -Name SQLSERVER -LiteralPath "c:\temp\"

#On the offline machine:
$env:PSModulePath.replace(";","`n")

# Copy the folder

Import-Module SQLSERVER

# Verify
Get-Module -ListAvailable -Name '*SQL*' | Select-Object Name, Version, RootModule
