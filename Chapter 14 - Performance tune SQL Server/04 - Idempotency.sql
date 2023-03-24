--Consider making UPDATE statements idempotent. This is a rather academic term that nonetheless is important to know. Idempotent describes functions that only take effect once, and are harmless if executed more than once. For example:
UPDATE dbo.Employee
SET Salary = Salary * 1.05
WHERE EmployeeID = 5;

--The previous query is not idempotent. Execution of the previous update statement would increase salary by 5% each time it is executed. The following statement is idempotent, and safer to execute because it would change data only once, and only for the intended original state of the row. If executed again, the UPDATE statement would safely affect 0 rows.
UPDATE dbo.Employee
SET Salary = Salary * 1.05
WHERE EmployeeID = 5 and Salary = 100000;

--The previous query is idempotent, and safer to execute.