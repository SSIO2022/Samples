--##############################################################################
--
-- SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
--
-- © 2022 MICROSOFT PRESS
--
--##############################################################################

/* Creates a new Azure SQL Database from a copy (taken from a backup) of another Azure SQL Database on the same server
  Prerequisites:
  Server administrator or dbamanager role
*/

CREATE DATABASE Contoso_copy AS COPY OF Server1.Contoso;
