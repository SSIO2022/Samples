--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

SELECT o.name
    , ips.partition_number
    , ips.index_type_desc
    , ips.record_count
    , ips.avg_record_size_in_bytes
    , ips.min_record_size_in_bytes
    , ips.max_record_size_in_bytes
    , ips.page_count
    , ips.compressed_page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'DETAILED') ips
JOIN sys.objects o ON o.object_id = ips.object_id
ORDER BY record_count DESC;