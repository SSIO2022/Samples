--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

/* set database offline: */
ALTER DATABASE [database_name] SET OFFLINE;

/* or */

ALTER DATABASE [database_name] SET OFFLINE WITH ROLLBACK IMMEDIATE;

/* set database online again */
ALTER DATABASE [database_name] SET ONLINE;