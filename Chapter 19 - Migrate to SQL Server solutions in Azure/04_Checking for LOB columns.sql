--Large Object data types may require special handling. In this context, large-value data types are those that exceed the maximum row size of 8 KB. Columns larger than 32 KB may get truncated at the target. You can use this code to determine which, if any, of your columns will be affected. This script may take a while to run on databases with many tables and columns.
DROP TABLE IF EXISTS #results;
CREATE TABLE #results (tablename nvarchar(256), columnname sysname, [datalength_bytes] bigint, INDEX cl_results CLUSTERED (tablename, columnname) );
DECLARE @tablename nvarchar(256), @columnname sysname;

DECLARE cur_columns CURSOR LOCAL FAST_FORWARD FOR
SELECT schema_name(o.schema_id)+'.['+o.name+']', c.name
FROM sys.columns AS c 
INNER JOIN sys.objects AS o ON c.object_id = o.object_id
WHERE o.type_desc = 'user_table';

OPEN cur_columns;
FETCH NEXT FROM cur_columns INTO @tablename, @columnname;

WHILE @@FETCH_STATUS=0
BEGIN
    INSERT INTO #results (tablename, columnname, [datalength_bytes])
    EXEC ('SELECT '''
          +@tablename+''', '''
          +@columnname+''', MAX(datalength(['+@columnname+']))'
		  +  ' FROM ' +@tablename);
    FETCH NEXT FROM cur_columns INTO @tablename, @columnname;
END    
CLOSE cur_columns;
DEALLOCATE cur_columns;

SELECT tablename, columnname, [datalength_bytes] FROM #results
WHERE [datalength_bytes] > 32765;
