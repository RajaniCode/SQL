/******************************************************************************/

-- SQLite

/******************************************************************************/

-- Command Line
>sqlite3 -version
3.8.7.2 2014-11-18 20:57:56 2ab564bf9655b7c7b97ab85cafc8a48329b27f93
-- OR
>sqlite3 -- version
3.8.7.2 2014-11-18 20:57:56 2ab564bf9655b7c7b97ab85cafc8a48329b27f93
> sqlite3
sqlite> .quit
-- OR
sqlite> .q
-- OR
sqlite> .exit
-- OR
sqlite> .ex


-- Git Bash
$ winpty sqlite3 -version
3.8.7.2 2014-11-18 20:57:56 2ab564bf9655b7c7b97ab85cafc8a48329b27f93
-- OR
$ winpty sqlite3 -- version
3.8.7.2 2014-11-18 20:57:56 2ab564bf9655b7c7b97ab85cafc8a48329b27f93
$ winpty sqlite3
> sqlite3
sqlite> .quit
-- OR
sqlite> .q
-- OR
sqlite> .exit
-- OR
sqlite> .ex


$ winpty sqlite3 customerdb.sqlite4
SQLite version 3.8.7.2 2014-11-18 20:57:56
Enter ".help" for usage hints.
sqlite> .databases
seq  name             file
-- -  -- -- -- -- -- -- -- -  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
0    main             E:\Working\SQL\SQLite\customerdb.sqlite4
sqlite> DROP TABLE IF EXISTS Customer;
sqlite> CREATE TABLE Customer
(
    CustomerId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    FirstName TEXT,
    LastName TEXT,
    Technology TEXT
);
sqlite> INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Bill', 'Gates', 'Microsoft');
sqlite> INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Larry', 'Page', 'Google');
sqlite> INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Steve', 'Jobs', 'Apple');
sqlite> INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Anders', 'Hejlsberg', 'C#');
sqlite> INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Bjarne', 'Stroustrup', 'C++');
sqlite> INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('James', 'Gosling', 'Java');
sqlite> INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Scott', 'Guthrie', 'ASP.NET');
sqlite> INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Don', 'Syme', 'F#');
sqlite> INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Dennis', 'Ritchie', 'C');
sqlite> INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Hasso', 'Plattner', 'SAP');
sqlite> SELECT * FROM Customer;
sqlite> INSERT INTO Customer(FirstName, LastName, Technology)
SELECT 'Brendan', 'Eich', 'JavaScript'
UNION ALL
SELECT 'Guido', 'van Rossum', 'Python'
UNION ALL
SELECT 'Yukihiro', 'Matsumoto', 'Ruby';
sqlite> SELECT * FROM Customer;
sqlite> INSERT INTO Customer (FirstName, LastName, Technology)
VALUES
('Rasmus', 'Lerdorf', 'PHP'),
('Martin', 'Odersky', 'Scala'),
('Donald', 'D. Chamberlin', 'SQL');
sqlite> SELECT * FROM Customer;
sqlite> .q


$ winpty sqlite3 customerdb.sqlite4
SQLite version 3.8.7.2 2014-11-18 20:57:56
Enter ".help" for usage hints.
sqlite> .help
.backup ?DB? FILE      Backup DB (default "main") to FILE
.bail on|off           Stop after hitting an error.  Default OFF
.clone NEWDB           Clone data into NEWDB from the existing database
.databases             List names and files of attached databases
.dump ?TABLE? ...      Dump the database in an SQL text format
                         If TABLE specified, only dump tables matching
                         LIKE pattern TABLE.
.echo on|off           Turn command echo on or off
.eqp on|off            Enable or disable automatic EXPLAIN QUERY PLAN
.exit                  Exit this program
.explain ?on|off?      Turn output mode suitable for EXPLAIN on or off.
                         With no args, it turns EXPLAIN on.
.fullschema            Show schema and the content of sqlite_stat tables
.headers on|off        Turn display of headers on or off
.help                  Show this message
.import FILE TABLE     Import data from FILE into TABLE
.indices ?TABLE?       Show names of all indices
                         If TABLE specified, only show indices for tables
                         matching LIKE pattern TABLE.
.load FILE ?ENTRY?     Load an extension library
.log FILE|off          Turn logging on or off.  FILE can be stderr/stdout
.mode MODE ?TABLE?     Set output mode where MODE is one of:
                         csv      Comma-separated values
                         column   Left-aligned columns.  (See .width)
                         html     HTML <table> code
                         insert   SQL insert statements for TABLE
                         line     One value per line
                         list     Values delimited by .separator string
                         tabs     Tab-separated values
                         tcl      TCL list elements
.nullvalue STRING      Use STRING in place of NULL values
.once FILENAME         Output for the next SQL command only to FILENAME
.open ?FILENAME?       Close existing database and reopen FILENAME
.output ?FILENAME?     Send output to FILENAME or stdout
.print STRING...       Print literal STRING
.prompt MAIN CONTINUE  Replace the standard prompts
.quit                  Exit this program
.read FILENAME         Execute SQL in FILENAME
.restore ?DB? FILE     Restore content of DB (default "main") from FILE
.save FILE             Write in-memory database into FILE
.schema ?TABLE?        Show the CREATE statements
                         If TABLE specified, only show tables matching
                         LIKE pattern TABLE.
.separator STRING ?NL? Change separator used by output mode and .import
                         NL is the end-of-line mark for CSV
.shell CMD ARGS...     Run CMD ARGS... in a system shell
.show                  Show the current values for various settings
.stats on|off          Turn stats on or off
.system CMD ARGS...    Run CMD ARGS... in a system shell
.tables ?TABLE?        List names of tables
                         If TABLE specified, only list tables matching
                         LIKE pattern TABLE.
.timeout MS            Try opening locked tables for MS milliseconds
.timer on|off          Turn SQL timer on or off
.trace FILE|off        Output each SQL statement as it is run
.vfsname ?AUX?         Print the name of the VFS stack
.width NUM1 NUM2 ...   Set column widths for "column" mode
                         Negative values right-justify
sqlite> .databases
seq  name             file
-- -  -- -- -- -- -- -- -- -  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
0    main             E:\Working\SQL\SQLite\customerdb.sqlite4
sqlite> .tables
Customer
sqlite> .schema Customer
CREATE TABLE Customer
(
    CustomerId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    FirstName TEXT,
    LastName TEXT,
    Technology TEXT
);
sqlite> .fullschema
CREATE TABLE Customer
(
    CustomerId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    FirstName TEXT,
    LastName TEXT,
    Technology TEXT
);
/* No STAT tables available */
sqlite> SELECT * FROM Customer;
1|Bill|Gates|Microsoft
2|Larry|Page|Google
3|Steve|Jobs|Apple
4|Anders|Hejlsberg|C#
5|Bjarne|Stroustrup|C++
6|James|Gosling|Java
7|Scott|Guthrie|ASP.NET
8|Don|Syme|F#
9|Dennis|Ritchie|C
10|Hasso|Plattner|SAP
11|Brendan|Eich|JavaScript
12|Guido|van Rossum|Python
13|Yukihiro|Matsumoto|Ruby
14|Rasmus|Lerdorf|PHP
15|Martin|Odersky|Scala
16|Donald|D. Chamberlin|SQL
sqlite> SELECT * FROM Customer UNION SELECT * FROM Customer;
1|Bill|Gates|Microsoft
2|Larry|Page|Google
3|Steve|Jobs|Apple
4|Anders|Hejlsberg|C#
5|Bjarne|Stroustrup|C++
6|James|Gosling|Java
7|Scott|Guthrie|ASP.NET
8|Don|Syme|F#
9|Dennis|Ritchie|C
10|Hasso|Plattner|SAP
11|Brendan|Eich|JavaScript
12|Guido|van Rossum|Python
13|Yukihiro|Matsumoto|Ruby
14|Rasmus|Lerdorf|PHP
15|Martin|Odersky|Scala
16|Donald|D. Chamberlin|SQL
sqlite> SELECT * FROM Customer UNION ALL SELECT * FROM Customer;
1|Bill|Gates|Microsoft
2|Larry|Page|Google
3|Steve|Jobs|Apple
4|Anders|Hejlsberg|C#
5|Bjarne|Stroustrup|C++
6|James|Gosling|Java
7|Scott|Guthrie|ASP.NET
8|Don|Syme|F#
9|Dennis|Ritchie|C
10|Hasso|Plattner|SAP
11|Brendan|Eich|JavaScript
12|Guido|van Rossum|Python
13|Yukihiro|Matsumoto|Ruby
14|Rasmus|Lerdorf|PHP
15|Martin|Odersky|Scala
16|Donald|D. Chamberlin|SQL
1|Bill|Gates|Microsoft
2|Larry|Page|Google
3|Steve|Jobs|Apple
4|Anders|Hejlsberg|C#
5|Bjarne|Stroustrup|C++
6|James|Gosling|Java
7|Scott|Guthrie|ASP.NET
8|Don|Syme|F#
9|Dennis|Ritchie|C
10|Hasso|Plattner|SAP
11|Brendan|Eich|JavaScript
12|Guido|van Rossum|Python
13|Yukihiro|Matsumoto|Ruby
14|Rasmus|Lerdorf|PHP
15|Martin|Odersky|Scala
16|Donald|D. Chamberlin|SQL
sqlite> .q


DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    -- id INTEGER NOT NULL,
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    username VARCHAR(50) NOT NULL, 
    login_date DATE DEFAULT CURRENT_DATE,
    login_time TIME DEFAULT CURRENT_TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT LOCALTIMESTAMP,    
    -- CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT idx_username UNIQUE(username)    
);

SELECT * FROM users;

INSERT INTO users(username, login_date, login_time, created_at, updated_at)
VALUES('Foo', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');

SELECT * FROM users;

INSERT INTO users
VALUES(0, 'Bar', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');

SELECT * FROM users;

SELECT ROWID,* FROM users WHERE ROWID > 0;

/******************************************************************************/

--  SQLite JOIN

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
-- RIGHT and FULL OUTER JOINs are not currently supported
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


/* CROSS JOIN -- NOTE: Pivot t1.ID */
SELECT t1.*, t2.* FROM Table1 t1
CROSS JOIN Table2 t2;

/******************************************************************************/

--  SQLite nth Highest

$ winpty sqlite3 employeedb.sqlite4
SQLite version 3.8.7.2 2014-11-18 20:57:56
Enter ".help" for usage hints.
sqlite> .databases
seq  name             file
-- -  -- -- -- -- -- -- -- -  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
0    main             E:\Working\SQL\SQLite\employeedb.sqlite4

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee
(ID INT, Name NVARCHAR(50), Salary numeric(15, 2));

INSERT INTO Employee
VALUES
(1, 'A', 10000), -- 4th
(2, 'B', 8000),  -- 5th
(3, 'C', 8000),  
(4, 'D', 6000),  -- 6th
(5, 'E', 6000),  
(6, 'F', 6000),
(7, 'G', 5000),  -- 7th  
(8, 'H', 5000),
(9, 'I', 5000),
(10, 'J', 5000),
(11, 'K', 4000),  -- 8th
(12, 'L', 4000),
(13, 'M', 3000),  -- 9th
(14, 'N', 3000),
(15, 'O', 1000),  -- 10th
(16, 'P', 14000), -- 2nd
(17, 'Q', 14000),
(18, 'R', 12000), -- 3rd
(19, 'S', 12000),
(20, 'T', 16000), -- 1st
(21, 'U', 16000), 
(22, 'V', 16000), 
(23, 'W', 14000),
(24, 'X', 12000),
(25, 'Y', 12000),
(26, 'Z', 10000);

SELECT * FROM Employee;

--  16000 -- 1st
--  14000 -- 2nd
--  12000 -- 3rd
--  10000 -- 4th
--   8000 -- 5th
--   6000 -- 6th
--   5000 -- 7th  
--   4000 -- 8th
--   3000 -- 9th
--   1000 -- 10th

--  nth Highest --  5th Highest --  8000
SELECT Salary FROM
(
SELECT DISTINCT Salary FROM Employee
ORDER BY Salary DESC LIMIT 5
)
A ORDER BY Salary LIMIT 1;
--  Alternatively
SELECT *
FROM Employee Emp1
WHERE (5 - 1) = (
SELECT COUNT(DISTINCT(Emp2.Salary))
FROM Employee Emp2
WHERE Emp2.Salary > Emp1.Salary) LIMIT 1;

--  2nd Highest --  14000
SELECT MAX(Salary) FROM Employee
WHERE Salary NOT IN (SELECT MAX(Salary) FROM Employee);

--  Alternatively
SELECT MAX(Salary) from Employee
WHERE Salary <> (select MAX(Salary) from Employee);

/******************************************************************************/


-- Credit:
/*
https://sqlite.org/
*/