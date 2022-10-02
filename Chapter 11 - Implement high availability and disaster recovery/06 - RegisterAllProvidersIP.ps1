###############################################################################
#
# SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
#
# © 2022 MICROSOFT PRESS
#
###############################################################################
#
# CHAPTER 11: IMPLEMENT HIGH AVAILABILITY AND DISASTER RECOVERY
# POWERSHELL SAMPLE 5
#

#To change the RegisterAllProvidersIP setting in the cluster network, you can use the following PowerShell script:
Import-Module FailoverClusters
# Get cluster network name
Get-ClusterResource -Cluster 'CLUSTER1'
Get-ClusterResource 'AG1_Network' -Cluster 'CLUSTER1' | `
   Get-ClusterParameter RegisterAllProvidersIP -Cluster 'CLUSTER1'
# 1 to enable, 0 to disable
Get-ClusterResource 'AG1_Network' -Cluster 'CLUSTER1' | `
    Set-ClusterParameter RegisterAllProvidersIP 1 -Cluster 'CLUSTER1'
# All changes will take effect once AG1 is taken offline and brought online again.
Stop-ClusterResource AG1_Network' -Cluster 'CLUSTER1'
Start-ClusterResource 'AG1_Network' -Cluster 'CLUSTER1'
# Must bring the AAG Back online
Start-ClusterResource 'AG1' -Cluster 'CLUSTER1'
# Should see the appropriate number of IPs listed now, one in each subnet.
nslookup Listener1
