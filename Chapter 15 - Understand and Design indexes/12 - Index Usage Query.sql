--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

SELECT TableName = sc.name + '.' + o.name
    , IndexName = i.name
    , s.user_seeks
    , s.user_scans
    , s.user_lookups
    , s.user_updates
    , ps.row_count
    , SizeMb = (ps.in_row_reserved_page_count * 8.) / 1024.
    , s.last_user_lookup
    , s.last_user_scan
    , s.last_user_seek
    , s.last_user_update
FROM sys.dm_db_index_usage_stats AS s
INNER JOIN sys.indexes AS i ON i.object_id = s.object_id
    AND i.index_id = s.index_id
INNER JOIN sys.objects AS o ON o.object_id = i.object_id
INNER JOIN sys.schemas AS sc ON sc.schema_id = o.schema_id
INNER JOIN sys.partitions AS pr ON pr.object_id = i.object_id
    AND pr.index_id = i.index_id
INNER JOIN sys.dm_db_partition_stats AS ps ON ps.object_id = i.object_id
    AND ps.partition_id = pr.partition_id
WHERE o.is_ms_shipped = 0
    --Don't consider dropping any constraints
    AND i.is_unique = 0
    AND i.is_primary_key = 0
    AND i.is_unique_constraint = 0
--Order by table reads asc, table writes desc
ORDER BY user_seeks + user_scans + user_lookups ASC
    , s.user_updates DESC;