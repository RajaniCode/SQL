--SQL Server


/* LEFT JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.ID = t2.ID
WHERE t2.ID IS NULL
GO

/* RIGHT JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.ID = t2.ID
WHERE t1.ID IS NULL
GO

/* OUTER JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1
FULL OUTER JOIN Table2 t2 ON t1.ID = t2.ID
WHERE t1.ID IS NULL OR t2.ID IS NULL
GO



/* Inner and Outer Join as Self Join */
IF OBJECT_ID('Employee', 'U') IS NOT NULL
DROP TABLE Employee
GO

-- Create a Table
CREATE TABLE Employee(
EmployeeID INT PRIMARY KEY,
Name NVARCHAR(50),
ManagerID INT
)
GO

-- Insert Sample Data
INSERT INTO Employee
SELECT 1, 'Mike', 3
UNION ALL
SELECT 2, 'David', 3
UNION ALL
SELECT 3, 'Roger', NULL
UNION ALL
SELECT 4, 'Marry',2
UNION ALL
SELECT 5, 'Joseph',2
UNION ALL
SELECT 7, 'Ben',2
GO

-- Check the data
SELECT *
FROM Employee
GO

-- Inner Join as Self Join
SELECT e1.Name EmployeeName, e2.name AS ManagerName
FROM Employee e1
INNER JOIN Employee e2
ON e1.ManagerID = e2.EmployeeID
GO

-- Outer Join as Self Join
SELECT e1.Name EmployeeName, ISNULL(e2.name, 'Top Manager') AS ManagerName
FROM Employee e1
LEFT JOIN Employee e2
ON e1.ManagerID = e2.EmployeeID
GO
