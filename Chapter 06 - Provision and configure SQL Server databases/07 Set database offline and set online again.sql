/* set database offline: */
ALTER DATABASE [database_name] SET OFFLINE;

/* or */

ALTER DATABASE [database_name] SET OFFLINE WITH ROLLBACK IMMEDIATE;

/* set database online again */
ALTER DATABASE [database_name] SET ONLINE