--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

SELECT Time_Observed = SYSDATETIMEOFFSET()
    , Buffer_Cache_Hit_Ratio = convert(INT, 100 * (
            SELECT cntr_value = convert(DECIMAL(9, 1), cntr_value)
            FROM sys.dm_os_performance_counters AS pc
            WHERE pc.COUNTER_NAME = 'Buffer cache hit ratio'
                AND pc.OBJECT_NAME LIKE ' % :Buffer Manager % '
            ) / (
            SELECT cntr_value = convert(DECIMAL(9, 1), cntr_value)
            FROM sys.dm_os_performance_counters AS pc
            WHERE pc.COUNTER_NAME = 'Buffer cache hit ratio base'
                AND pc.OBJECT_NAME LIKE ' % :Buffer Manager % '
            ));