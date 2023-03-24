# Install or update your local Azure PowerShell with the following:
Install-Module -Name Az
Update-Module -Name Az

# To create the VPN gateway, you will need the subscription ID, resource group, and a virtual network name that you used to create your managed instance. You will also need to create a certificate name prefix. The prefix is a string that you choose. These items are used in the following PowerShell script:
$scriptUrlBase = 'https://raw.githubusercontent.com/Microsoft/sql-server-samples/master/samples/manage/azure-sql-db-managed-instance/attach-vpn-gateway'
$parameters = @{
  subscriptionId = '<subscriptionId>'
  resourceGroupName = '<resourceGroupName>'
  virtualNetworkName = '<virtualNetworkName>'
  certificateNamePrefix  = '<certificateNamePrefix>'
  }
Invoke-Command -ScriptBlock ([Scriptblock]::Create((iwr ($scriptUrlBase+'/attachVPNGateway.ps1?t='+ [DateTime]::Now.Ticks)).Content)) -ArgumentList $parameters, $scriptUrlBase
