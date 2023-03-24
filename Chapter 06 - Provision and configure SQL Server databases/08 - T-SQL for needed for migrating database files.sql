/*
##############################################################################

	SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"

	© 2022 MICROSOFT PRESS

##############################################################################
*/

ALTER DATABASE [database_name] SET OFFLINE WITH ROLLBACK IMMEDIATE;

ALTER DATABASE [database_name] MODIFY FILE (
    NAME = logical_data_file_name
    , FILENAME = 'location\physical_data_file_name.mdf');

ALTER DATABASE [database_name] MODIFY FILE (
    NAME = logical_log_file_name
    , FILENAME = 'location\physical_log_file_name.ldf');

/* ensure database files have been moved prior to running the following: */
ALTER DATABASE [database_name] SET ONLINE;
