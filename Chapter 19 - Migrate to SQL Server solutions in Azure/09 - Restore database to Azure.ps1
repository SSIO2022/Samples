## Generate new SAS token that will read .bak file
$sas = (New-AzStorageAccountSASToken -Service Blob -ResourceType Object -Permission "r" -Context $ctx).TrimStart(‘?’) # -ResourceType Container,Object
$targetLogin = Get-Credential -Message "Login to target Managed Instance as:"
$target = Connect-DbaInstance -SqlInstance $targetInstance `
    -SqlCredential $targetLogin
$targetCred = New-DbaCredential -SqlInstance $target `
    -Name "https://$blobStorageAccount.blob.core.windows.net/$containerName" `
    -Identity "SHARED ACCESS SIGNATURE" `
    -SecurePassword (ConvertTo-SecureString $sas -AsPlainText -Force) `
    -Force
Restore-DbaDatabase -SqlInstance $target -Database $targetDatabase `
    -Path "https://$blobStorageAccount.blob.core.windows.net/$containerName/WideWorldImporters.bak"
