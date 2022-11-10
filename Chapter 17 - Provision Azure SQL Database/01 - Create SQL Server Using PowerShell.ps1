<# Use this script to create a server to be used by Azure SQL Database. 
    Prerequisites: 
        Existing resource group that will contain the server
        Adequate permissions to create a server
        Key vault with a secret that contains the SQL login password
        Az module installed in PowerShell
#>

# Change the variables on lines 10-14 to fit your environment
$resourceGroupName = "SSIO2022"
$location = "southcentralus"
$serverName = "ssio2022"
$adminSqlLogin = "SQLAdmin"
$adminSqlSecret = Get-AzKeyVaultSecret -VaultName 'SSIO-KV' -Name 'SQLAdminPwd'
$tags = @{"CreatedBy"="Kirby"; "Environment"="Dev"}
$cred = $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $($adminSqlSecret.SecretValue) )
New-AzSqlServer -ResourceGroupName $resourceGroupName `
   -ServerName $serverName `
   -Location $location `
   -SqlAdministratorCredentials $cred `
   -AssignIdentity `
   -IdentityType "SystemAsssigned" `
   -Tags $tags