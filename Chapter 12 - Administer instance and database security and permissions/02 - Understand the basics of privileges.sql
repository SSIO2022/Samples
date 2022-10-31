--Security Prinicpals\The basics of privileges

--Here is the basic syntax of the security statements:

--note: examples only
GRANT  permission(s) ON objecttype::Securable TO principal;
DENY  permission(s)  ON objecttype::Securable TO principal;
REVOKE permission(s) ON objecttype::Securable  FROM | TO principal;

/*
The ON portion of the permission statement may be optional depending on whether you are applying permission to a specific resource, or to the entire database or server. For example, omit the ON portion to grant a permission to a principal for the current database by doing this:
*/


GRANT EXECUTE TO [domain\katie.sql];

/*
Hence, you may be granted access to read some data, for example in a schema named Sales, through multiple methods. You may also be denied via another path. GRANT and DENY oppose each other, with DENY taking precedence. To demonstrate, consider the following opposing GRANT and DENY statements run from an administrative account on the WideWorldImporters sample database:
*/

GRANT SELECT on SCHEMA::Sales to [domain\katie.sql];
DENY SELECT on OBJECT::Sales.InvoiceLines to [domain\katie.sql];

--Or you can grant [Domain\Katie_sql] access to insert, update, and delete data using:

GRANT INSERT, UPDATE, DELETE on SCHEMA::Sales to [domain\katie.sql];

--It doesn’t matter how many times you are granted access to a resource, DENY overrides it. You can delete the DENY using:

REVOKE SELECT on OBJECT::Sales.Invoices to [domain\katie.sql];

/*
And then delete the original GRANT using the following statements (which can be condensed into one statement, if desired, they needn’t match the GRANT):
*/

REVOKE SELECT on SCHEMA::Sales to [domain\katie.sql];
REVOKE INSERT, UPDATE, DELETE on SCHEMA::Sales to [domain\katie.sql];
