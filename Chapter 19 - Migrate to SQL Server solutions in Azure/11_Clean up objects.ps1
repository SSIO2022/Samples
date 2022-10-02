$resourceGroupName = "YourResourceGroupName"
$blobStorageAccountName = "newstorageaccountname"
Remove-AzStorageAccount -ResourceGroupName $resourceGroupName `
    -Name $blobStorageAccountName `
    -Force
