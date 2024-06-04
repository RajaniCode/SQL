# MySQL

DROP DATABASE IF EXISTS JoinExample;

CREATE DATABASE JoinExample;

USE JoinExample;
DROP TABLE IF EXISTS Table1;


CREATE TABLE Table1
(ID INT, Value VARCHAR(10));

INSERT INTO Table1 (ID, Value)
SELECT 1, 'First'
UNION ALL
SELECT 2, 'Second'
UNION ALL
SELECT 3, 'Third'
UNION ALL
SELECT 4, 'Fourth'
UNION ALL
SELECT 5, 'Fifth';

DROP TABLE IF EXISTS Table2;

CREATE TABLE Table2
(ID INT, Value VARCHAR(10));

INSERT INTO Table2 (ID, Value)
SELECT 1, 'I'
UNION ALL
SELECT 2, 'II'
UNION ALL
SELECT 3, 'III'
UNION ALL
SELECT 6, 'VI'
UNION ALL
SELECT 7, 'VII'
UNION ALL
SELECT 8, 'VIII';


SELECT * FROM Table1;
SELECT * FROM Table2;


/* (INNER) JOIN */
SELECT t1.*, t2.* FROM Table1 t1
INNER JOIN Table2 t2 ON t1.ID = t2.ID;


/* LEFT (OUTER) JOIN */
SELECT t1.*, t2.* FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.ID = t2.ID;


/* RIGHT (OUTER) JOIN */
SELECT t1.*, t2.* FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.ID = t2.ID;


/* 
#NO FULL (OUTER) JOIN IN MYSQL 
SELECT t1.*, t2.* FROM Table1 t1
FULL JOIN Table2 t2 ON t1.ID = t2.ID;
*/


/* Emulate FULL (OUTER) JOIN # NOTE: NULLS LAST */
SELECT * FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.id = t2.id
UNION
SELECT * FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.id = t2.id;


/* CROSS JOIN # NOTE: Pivot t2.ID (Differs From SQL Server, PostgreSQL) */
SELECT t1.*, t2.* FROM Table1 t1
CROSS JOIN Table2 t2;
