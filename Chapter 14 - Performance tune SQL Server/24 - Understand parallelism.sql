--You can also specify MAXDOP when creating indexes. You cannot specify a MAXDOP for the reorganize step.
ALTER INDEX ALL ON WideWorldImporters.Sales.Invoices REBUILD
WITH (MAXDOP = 1, ONLINE = ON);
