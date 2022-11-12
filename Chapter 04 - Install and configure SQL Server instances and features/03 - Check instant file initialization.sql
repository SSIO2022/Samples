/* 
    ##############################################################################

    SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

    © MICROSOFT PRESS

    ##############################################################################
*/

SELECT [servicename], [instant_file_initialization_enabled]
FROM [sys].[dm_server_services]
WHERE [filename] LIKE '%sqlservr.exe%';
