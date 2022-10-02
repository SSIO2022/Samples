SELECT name, temporal_type, temporal_type_desc
FROM sys.tables
WHERE temporal_type <> 0;
