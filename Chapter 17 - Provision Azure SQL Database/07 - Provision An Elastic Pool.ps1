<# Creates an Azure SQL elastic pool in an existing resource group for an existing server. 
  Then moves existing Azure SQL database into the elastic pool.
  Pre-requisites: 
    Existing resource group
    Existing Azure SQL server
    Existing Azure SQL database
    Az module installed in PowerShell
  Update values in lines 11 - 14 and 20 - 24 to fit your environment
#>

$resourceGroupName = "SSIO2022"
$serverName = "ssio2022"
$databaseName = "Contoso"
$poolName = "Contoso-Pool"

# Create a new elastic pool
New-AzSqlElasticPool -ResourceGroupName $resourceGroupName `
   -ServerName $serverName `
   -ElasticPoolName $poolName `
   -Edition "GeneralPurpose" `
   -Vcore 4 `
   -ComputeGeneration Gen5 `
   -DatabaseVCoreMin 0 `
   -DatabaseVCoreMax 2

# Now move the Contoso database to the pool
Set-AzSqlDatabase -ResourceGroupName $resourceGroupName `
   -ServerName $serverName `
   -DatabaseName $databaseName `
   -ElasticPoolName $poolName
