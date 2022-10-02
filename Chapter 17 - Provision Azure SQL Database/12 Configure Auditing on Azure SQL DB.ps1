<# Configures auditing for an existing Azure SQL Database
  Prerequisites: 
    Existing Azure SQL database
    Az module installed in PowerShell
    Permissions to modify the SQL database audit settings
    Permissions to create a storage account
  Update the values in lines 10 - 15 and 25 to match your environment
  #>

$resourceGroupName = "SSIO2022"
$location = "southcentralus"
$serverName = "ssio2022"
$databaseName = "Contoso"
# Create your own globally unique name here
$storageAccountName = "azuresqldbaudit"
# Create a new storage account
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName `
   -Name $storageAccountName -Location $location -Kind Storage `
   -SkuName Standard_LRS -EnableHttpsTrafficOnly $true
# Use the new storage account to configure auditing
$auditSettings = Set-AzSqlDatabaseAudit `
    -ResourceGroupName $resourceGroupName `
    -ServerName $serverName -DatabaseName $databaseName `
    -StorageAccountResourceId $storageAccount.Id -StorageKeyType Primary `
    -RetentionInDays 365 -BlobStorageTargetState Enabled
