/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

/*  For example, the ALTER statement that follows provides a read-only routing 
    list for a three-node availability group that is not load balanced. All 
    read-only queries will be sent to the secondary node SQLSERVER-1, and if it 
    is unavailable, to SQLSERVER-2, and if that is also unavailable, to SQLSERVER-0. 
    This is the behavior prior to SQL Server 2016. */
ALTER AVAILABILITY GROUP [wwi]
    MODIFY REPLICA ON 'SQLSERVER-0'
    WITH (PRIMARY_ROLE(READ_ONLY_ROUTING_LIST = ('SQLSERVER-1', 'SQLSERVER-2', 'SQLSERVER-0')));

/*  This ALTER statement provides a read-only routing list that is load balanced. 
    Note the extra set of parentheses. With the configuration in the following 
    sample, read-only traffic will be routed to a load-balance group of SQLSERVER-1 
    and SQLSERVER-0, but failing those connections, to SQLSERVER-0: */
ALTER AVAILABILITY GROUP [wwi]
    MODIFY REPLICA ON 'SQLSERVER-0'
    WITH (PRIMARY_ROLE(READ_ONLY_ROUTING_LIST =(('SQLSERVER-1', 'SQLSERVER-2'), 'SQLSERVER-0')));
