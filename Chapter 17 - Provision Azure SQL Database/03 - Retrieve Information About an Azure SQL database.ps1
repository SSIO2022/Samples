<# Retrieve information about an existing database
  Useful immediately after creating the database, to validate your work
  Prerequisites: 
    An existing Azure SQL Database
    Az Module installed in PowerShell
  Replace the values on lines 9 - 11 to fit your environment
#> 

$resourceGroupName = "SSIO2022"
$serverName = "ssio2022"
$databaseName = "Contoso"
Get-AzSqlDatabase -ResourceGroupName $resourceGroupName `
-ServerName $serverName `
-DatabaseName $databaseName
