--SQLite


DROP TABLE Table1

CREATE TABLE Table1
(
    ID INT, 
    Value VARCHAR(10)
);

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


DROP TABLE Table2

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
JOIN Table2 t2 ON t1.ID = t2.ID;


/* LEFT (OUTER) JOIN */
SELECT t1.*, t2.* FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.ID = t2.ID;


/* 
--RIGHT and FULL OUTER JOINs are not currently supported
SELECT t1.*, t2.* FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.ID = t2.ID;

SELECT t1.*, t2.* FROM Table1 t1
FULL OUTER JOIN Table2 t2 ON t1.ID = t2.ID;

SELECT * FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.id = t2.id
UNION
SELECT * FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.id = t2.id;
*/


/* CROSS JOIN --NOTE: Pivot t1.ID */
SELECT t1.*, t2.* FROM Table1 t1
CROSS JOIN Table2 t2;