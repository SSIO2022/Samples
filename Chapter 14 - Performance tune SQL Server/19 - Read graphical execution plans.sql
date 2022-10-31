--In the next list, we review some of the most common things to look for as you review execution plans in SSMS.
--First, start an execution plan. For our purposes, a simple one like for the following query:
SELECT Invoices.InvoiceID
FROM Sales.Invoices
WHERE Invoices.InvoiceID like '1%';
