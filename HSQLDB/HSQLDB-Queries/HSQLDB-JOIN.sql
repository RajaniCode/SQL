--HSQLDB

DROP TABLE IF EXISTS Table1;

CREATE TABLE Table1
(ID INT, Value VARCHAR(10));
SELECT * FROM Table1;

INSERT INTO Table1 (ID, Value)
VALUES(1, 'First');

INSERT INTO Table1 (ID, Value)
VALUES(2, 'Second');

INSERT INTO Table1 (ID, Value)
VALUES(3, 'Third');

INSERT INTO Table1 (ID, Value)
VALUES(4, 'Fourth');

INSERT INTO Table1 (ID, Value)
VALUES(5, 'Fifth');

SELECT * FROM Table1;


DROP TABLE IF EXISTS Table2;

CREATE TABLE Table2
(ID INT, Value VARCHAR(10));
SELECT * FROM Table2;

INSERT INTO Table2 (ID, Value)
VALUES(1, 'I');

INSERT INTO Table2(ID, Value)
VALUES(2, 'II');

INSERT INTO Table2 (ID, Value)
VALUES(3, 'III');

INSERT INTO Table2 (ID, Value)
VALUES(6, 'VI');

INSERT INTO Table2 (ID, Value)
VALUES(7, 'VII');

INSERT INTO Table2 (ID, Value)
VALUES(8, 'VIII');

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


/* FULL (OUTER) JOIN */
SELECT t1.*, t2.* FROM Table1 t1
FULL JOIN Table2 t2 ON t1.ID = t2.ID;


/* Emulate FULL (OUTER) JOIN --NOTE: NULLS LAST */
SELECT * FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.id = t2.id
UNION
SELECT * FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.id = t2.id;


/* CROSS JOIN --NOTE: Pivot t2.ID (Differs From SQL Server, PostgreSQL) */
SELECT t1.*, t2.* FROM Table1 t1
CROSS JOIN Table2 t2;
