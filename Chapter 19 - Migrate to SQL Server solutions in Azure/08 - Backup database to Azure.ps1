$sourceInstance = "servername" # or servername/instancename
$sourcedatabase = "databasename"
Backup-DbaDatabase -SqlInstance $sourceInstance -Database $sourceDatabase `
    -AzureBaseUrl "https://$blobStorageAccount.blob.core.windows.net/$containerName" `
    -BackupFileName "WideWorldImporters.bak" `
    -Type Full `
    -Checksum `
    -CopyOnly
