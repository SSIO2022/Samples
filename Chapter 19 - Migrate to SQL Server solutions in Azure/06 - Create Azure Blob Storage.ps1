$resourceGroup = "YourResourceGroupName"
$location = "northeurope" # Refer to Get-AzLocation
$blobStorageAccountName = "newstorageaccountname" # must be unique in Azure
New-AzResourceGroup -Name $resourceGroup -Location $location
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroup `
    -Name $blobStorageAccountName `
    -Location $location `
    -SkuName "Standard_LRS" `
    -Kind "StorageV2"
$ctx = $storageAccount.Context
New-AzStorageContainer -Name $containerName -Context $ctx -Permission Container
