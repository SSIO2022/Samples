SELECT s.name 'Schema', T.name 'Table Name', G.name 'Trigger'
FROM sys.tables AS T
INNER JOIN sys.triggers AS G ON G.parent_id = T.object_id
INNER JOIN sys.schemas AS S ON s.schema_id = t.schema_id
WHERE is_disabled = 0;