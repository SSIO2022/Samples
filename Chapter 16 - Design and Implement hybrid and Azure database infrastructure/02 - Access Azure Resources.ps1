# you must login and connect to Azure
Connect-AzAccount 

# this will tell you what subscription you are currently connected to
Get-AzContext 

# or use the following to list all subscriptions you could connect to
Get-AzSubscription
# A list of subscriptions is displayed.
# You can copy and paste a subscription name on the next line.
Select-AzSubscription -SubscriptionName 'Pay-As-You-Go'
