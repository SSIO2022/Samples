--For an example of an execution plan, consider the following query in the WideWorldImporters database:
SELECT * FROM Sales.Invoices
JOIN Sales.Customers
on Customers.CustomerId = Invoices.CustomerId
WHERE Invoices.InvoiceID like '1%';



SELECT Invoices.InvoiceID
FROM Sales.Invoices
WHERE Invoices.InvoiceID like '1%';
--In the XML, in the node for the Index Scan, you see:
-- <RunTimeInformation>
-- <RunTimeCountersPerThread Thread=”0” ActualRows=”11111” ActualRowsRead=”70510”
-- ...
