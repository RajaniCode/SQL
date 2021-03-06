-- Oracle 11 g

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Table1 CASCADE CONSTRAINTS PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;


CREATE TABLE Table1
(ID INT, Value VARCHAR(10));

INSERT INTO Table1 (ID, Value)
SELECT 1,'First' FROM DUAL
UNION ALL
SELECT 2,'Second' FROM DUAL
UNION ALL
SELECT 3,'Third' FROM DUAL
UNION ALL
SELECT 4,'Fourth' FROM DUAL
UNION ALL
SELECT 5,'Fifth' FROM DUAL;


BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Table2 CASCADE CONSTRAINTS PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;


CREATE TABLE Table2
(ID INT, Value VARCHAR(10));

INSERT INTO Table2 (ID, Value)
SELECT 1,'I' FROM DUAL
UNION ALL
SELECT 2,'II' FROM DUAL
UNION ALL
SELECT 3,'III' FROM DUAL
UNION ALL
SELECT 6,'VI' FROM DUAL
UNION ALL
SELECT 7,'VII' FROM DUAL
UNION ALL
SELECT 8,'VIII' FROM DUAL;


SELECT * FROM Table1;
SELECT * FROM Table2;


/* (INNER) JOIN */
SELECT t1.*, t2.* FROM Table1 t1
JOIN Table2 t2 ON t1.ID = t2.ID;


/* LEFT (OUTER) JOIN */
SELECT t1.*, t2.* FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.ID = t2.ID;


/* RIGHT (OUTER) JOIN */
SELECT t1.*, t2.* FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.ID = t2.ID;


/* FULL (OUTER) JOIN --NOTE: Neither NULLS FIRST Nor NULLS LAST */
SELECT t1.*, t2.* FROM Table1 t1
FULL JOIN Table2 t2 ON t1.ID = t2.ID;


/* FULL (OUTER) JOIN NULLS LAST */
SELECT t1.*,t2.* FROM Table1 t1
FULL JOIN Table2 t2 ON t1.ID = t2.ID order by t1.ID ASC NULLS LAST;


/* Emulate FULL (OUTER) JOIN --NOTE: NULLS LAST, Column Names */
SELECT * FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.id = t2.id
UNION
SELECT * FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.id = t2.id;


/* CROSS JOIN --NOTE: Pivot t1.ID */
SELECT t1.*,t2.* FROM Table1 t1
CROSS JOIN Table2 t2;