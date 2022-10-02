################################################################################
##
## SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
##
## © 2022 MICROSOFT PRESS
##
################################################################################
##
## CHAPTER 9: AUTOMATE SQL SERVER ADMINISTRATION
## POWERSHELL SAMPLE 5


# 1a
$instanceName = "azure-databasename.database.windows.net"
Invoke-Sqlcmd -Database master -ServerInstance $instanceName `
    -Query "SELECT * FROM sys.dm_exec_sessions" | `
    Format-Table | Out-File -FilePath "C:\Temp\Sessions.txt" -Append

# 1b
# Same example as above using SQL Authentication
$instanceName = "azure-databasename.database.windows.net"
Invoke-Sqlcmd -Database master -ServerInstance $instanceName `
    -Username user -Password 'strongpassword' `
    -Query "SELECT * FROM sys.dm_exec_sessions" | `
    Format-Table | Out-File -FilePath "C:\Temp\Sessions.txt" -Append

#2
$instanceName = "localhost"
Invoke-Sqlcmd -Database master -ServerInstance $instanceName `
	-Query "SELECT * FROM sys.dm_exec_sessions" | `
	Out-GridView
