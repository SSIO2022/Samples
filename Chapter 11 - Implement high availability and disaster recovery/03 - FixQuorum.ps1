###############################################################################
#
# SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
#
# © 2022 MICROSOFT PRESS
#
###############################################################################
#
# CHAPTER 11: IMPLEMENT HIGH AVAILABILITY AND DISASTER RECOVERY
# POWERSHELL SAMPLE 2
#

#You will not be able to force a failover for availability groups based on a WSFC if the WSFC has no quorum.   You will first have to force quorum  in the Configuration Manager by â€œriggingâ€ the vote and modifying node weights. You should consider this step only in emergencies, such as when a disaster has disrupted a majority of cluster nodes.
#You can accomplish this with a relatively straightforward PowerShell script, to force an online node to assume the primary role without a majority of votes. 

Import-Module FailoverClusters
$node = 'desired_primary_servername'
Stop-ClusterNode -Name $node
Start-ClusterNode -Name $node -FixQuorum
#FixQuorum forces the cluster to start
# without a valid quorum, which we’re about to fix
(Get-ClusterNode $node).NodeWeight = 1
$nodes = Get-ClusterNode -Cluster $node
#Force this node’s weight in the quorum
