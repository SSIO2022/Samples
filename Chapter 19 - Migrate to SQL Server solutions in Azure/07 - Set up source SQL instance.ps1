$sourceInstance = "servername" # or servername/instancename
$sas = (New-AzStorageAccountSASToken -Service Blob -ResourceType Object -Permission "rw" -Context $ctx).TrimStart("?")
$sourceCred = New-DbaCredential -SqlInstance $sourceInstance `
    -Name "https://$blobStorageAccount.blob.core.windows.net/$containerName" `
    -Identity "SHARED ACCESS SIGNATURE" `
    -SecurePassword (ConvertTo-SecureString $sas -AsPlainText -Force)
