-- SQLite

$ winpty sqlite3 employeedb.sqlite4
SQLite version 3.8.7.2 2014-11-18 20:57:56
Enter ".help" for usage hints.
sqlite> .databases
seq  name             file
---  ---------------  ----------------------------------------------------------
0    main             E:\Working\SQL\SQLite\employeedb.sqlite4

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee
(ID INT, Name NVARCHAR(50), Salary numeric(15, 2));

INSERT INTO Employee
VALUES
(1, 'A', 10000), --4th
(2, 'B', 8000),  --5th
(3, 'C', 8000),  
(4, 'D', 6000),  --6th
(5, 'E', 6000),  
(6, 'F', 6000),
(7, 'G', 5000),  --7th  
(8, 'H', 5000),
(9, 'I', 5000),
(10, 'J', 5000),
(11, 'K', 4000),  --8th
(12, 'L', 4000),
(13, 'M', 3000),  --9th
(14, 'N', 3000),
(15, 'O', 1000),  --10th
(16, 'P', 14000), --2nd
(17, 'Q', 14000),
(18, 'R', 12000), --3rd
(19, 'S', 12000),
(20, 'T', 16000), --1st
(21, 'U', 16000), 
(22, 'V', 16000), 
(23, 'W', 14000),
(24, 'X', 12000),
(25, 'Y', 12000),
(26, 'Z', 10000);

SELECT * FROM Employee;

-- 16000 --1st
-- 14000 --2nd
-- 12000 --3rd
-- 10000 --4th
--  8000 --5th
--  6000 --6th
--  5000 --7th  
--  4000 --8th
--  3000 --9th
--  1000 --10th

-- nth Highest -- 5th Highest -- 8000
SELECT Salary FROM
(
SELECT DISTINCT Salary FROM Employee
ORDER BY Salary DESC LIMIT 5
)
A ORDER BY Salary LIMIT 1;
-- Alternatively
SELECT *
FROM Employee Emp1
WHERE (5 - 1) = (
SELECT COUNT(DISTINCT(Emp2.Salary))
FROM Employee Emp2
WHERE Emp2.Salary > Emp1.Salary) LIMIT 1;

-- 2nd Highest -- 14000
SELECT MAX(Salary) FROM Employee
WHERE Salary NOT IN (SELECT MAX(Salary) FROM Employee);

-- Alternatively
SELECT MAX(Salary) from Employee
WHERE Salary <> (select MAX(Salary) from Employee);


/* 
-- SQL Server

;WITH CTE(Salary, Rnk) AS 
(
	SELECT Salary, Rnk = DENSE_RANK() OVER (ORDER BY Salary DESC) FROM Employee
) 
SELECT DISTINCT Salary FROM CTE WHERE Rnk = 5;


/* TOP 1 just grabs one of them, while DISTINCT does imply a sort and therefore might be more costly without any obvious benefit */
WITH CTE AS 
(
	SELECT Salary, Rnk = DENSE_RANK() OVER (ORDER BY Salary DESC) FROM Employee
) 
SELECT TOP 1 Salary FROM CTE WHERE Rnk = 5;
*/