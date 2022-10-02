# temporary resources needed for backups
$location = "westus"
$resourceGroup = "temp-migration-demo-rg"
$blobStorageAccount = "temp-demostorage"
$containerName = "backups"

 # source and target instances
$sourceInstance = "SOURCESQLSERVER"
$sourceDatabase = "WideWorldImporters"
 $targetInstance = "targetmi.public.920d05d7463d.database.windows.net,3342"
$targetDatabase = "WideWorldImporters"
