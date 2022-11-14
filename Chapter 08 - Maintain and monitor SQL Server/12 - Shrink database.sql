/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

-- You should almost never run this code
USE [WideWorldImporters];

-- TRUNCATEONLY returns all free space to the OS 
DBCC SHRINKFILE (
        N'WWI_Log'
        , 0
        , TRUNCATEONLY
        );
GO

USE [master];

ALTER DATABASE [WideWorldImporters] MODIFY FILE (
    NAME = N'WWI_Log'
    , SIZE = 8192000 KB
    );

ALTER DATABASE [WideWorldImporters] MODIFY FILE (
    NAME = N'WWI_Log'
    , SIZE = 9437184 KB
    );
GO

