/* Creates a database-level firewall rule named Headquarters, 
expands the IP range, 
validates the firewall rule exists as expected, 
then deletes the firewall rule
*/

--Create firewall rule
EXEC sp_set_database_firewall_rule N'Headquarters', '1.2.3.4', '1.2.3.4';

--Update firewall rule
EXEC sp_set_database_firewall_rule N'Headquarters', '1.2.3.4', '1.2.3.6';

--Find firewall rule in system view
SELECT * FROM sys.database_firewall_rules;

--Delete firewall rule
EXEC sp_delete_database_firewall_rule N'Headquarters';
