################################################################################
##
## SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
##
## Â© 2022 MICROSOFT PRESS
##
################################################################################
##
## CHAPTER 9: AUTOMATE SQL SERVER ADMINISTRATION
## POWERSHELL SAMPLE 1

Get-Module -ListAvailable -Name ‘*sql*’ | Select-Object Name, Version, RootModule

#Basic Reference
Get-Help Invoke-SqlCmd

#See actual examples of code use
Get-Help Invoke-SqlCmd - Examples

#All cmdlets that match a wildcard search
Get-Help -Name “*Backup*database*”
