/*
    ##############################################################################

    SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

    © MICROSOFT PRESS

    ##############################################################################
*/

SELECT [object_name], [counter_name], [instance_name], [cntr_value], [cntr_type]
FROM [sys].[dm_os_performance_counters]
WHERE [object_name] = 'SQLServer:Deprecated Features';
