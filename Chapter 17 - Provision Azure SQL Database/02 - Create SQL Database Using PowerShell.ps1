<# Creates a database on an existing Azure SQL server
  Prerequisites: 
    Existing resource group
    Existing server
    Permissions to create an Azure SQL Database
    Az module installed in PowerShell
  Update the values in lines 10-12 and 15-19 to fit your environment
#> 
$resourceGroupName = "SQL2022"
$serverName = "ssio2022"
$databaseName = "Contoso"
$tags = @{"CreatedBy"="Kirby"; "Environment"="Dev"}
New-AzSqlDatabase -ResourceGroupName $resourceGroupName `
   -ServerName $serverName `
   -Edition "GeneralPurpose" `
   -Vcore 2 `
   -ComputeGeneration "Gen5" `
   -ComputeMode "Provisioned" `
   -CollationName "Latin1_General_CI_AS" `
   -DatabaseName $databaseName `
   -Tags $tags