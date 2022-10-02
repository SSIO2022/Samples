################################################################################
##
## SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
##
## © 2022 MICROSOFT PRESS
##
################################################################################
##
## CHAPTER 9: AUTOMATE SQL SERVER ADMINISTRATION
## POWERSHELL SAMPLE 3

#Backup all databases (except for TempDB)
$instanceName = "localhost"  #set instance to back up
$path = "F:\Backup" 
Get-SqlDatabase -ServerInstance $instanceName | `
    Where-Object { $_.Name -ne 'tempdb' } | `
    ForEach-Object {
    Backup-SqlDatabase -DatabaseObject $_ `
        -BackupAction "Database" `
        -CompressionOption On `
        -BackupFile "$($path)\$($_.Name)\$($_.Name)_$(Get-Date -Format "yyyyMMdd")_$(Get-Date -Format "HHmmss_FFFF").bak" `
        -Script #The -Script generates TSQL, but does not execute
} 
