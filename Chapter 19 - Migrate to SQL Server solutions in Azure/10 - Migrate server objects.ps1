$sourceInstance = "servername" # or servername/instancename
$targetInstance = "myserver.public.instancename.database.windows.net,3342 " # Azure SQL Managed Instance name with port
$targetLogin = Get-Credential # provide sign in credential for the target SQL Server instance, for example, a SQL Authenticated username and password
Copy-DbaSysDbUserObject -Source $sourceInstance `
    -Destination $targetInstance `
    -DestinationSqlCredential $targetLogin
Copy-DbaDbMail -Source $sourceInstance `
    -Destination $targetInstance `
    -DestinationSqlCredential $targetLogin
Copy-DbaAgentOperator -Source $sourceInstance `
    -Destination $targetInstance `
    -DestinationSqlCredential $targetLogin
Copy-DbaAgentJobCategory -Source $sourceInstance `
    -Destination $targetInstance `
    -DestinationSqlCredential $targetLogin
Copy-DbaAgentJob -Source $sourceInstance `
    -Destination $.targetInstance `
    -DestinationSqlCredential $targetLogin
Copy-DbaAgentSchedule -Source $sourceInstance `
    -Destination $targetInstance `
    -DestinationSqlCredential $targetLogin
Copy-DbaLogin -Source $sourceInstance `
    -Destination $targetInstance `
    -DestinationSqlCredential $targetLogin `
    -ExcludeSystemLogins
Copy-DbaLinkedServer -Source $sourceInstance `
    -Destination $targetInstance `
    -DestinationSqlCredential $targetLogin 
Copy-DbaEndpoint -Source $sourceInstance `
    -Destination $targetInstance `
    -DestinationSqlCredential $targetLogin
