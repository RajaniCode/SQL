--Remove duplicate rows from a table
/*
How to remove duplicate rows from a table in SQL Server 
http://support.microsoft.com/kb/139444
*/
USE [master];
GO

IF EXISTS(SELECT name FROM sys.databases WHERE NAME = N'temporarydb')
DROP DATABASE temporarydb;
GO

CREATE DATABASE temporarydb;
GO

USE [temporarydb];
GO

IF EXISTS(SELECT name FROM sys.tables WHERE NAME = N't1')
DROP TABLE t1;
GO

create table t1(col1 int, col2 int, col3 char(50))
insert into t1 values (1, 1, 'data value one')
insert into t1 values (1, 1, 'data value one')
insert into t1 values (1, 2, 'data value two')
GO

SELECT * FROM t1;
GO

/*
The first step is to identify which rows have duplicate primary key values: 

This will return one row for each set of duplicate PK values in the table. 
The last column in this result is the number of duplicates for the particular PK value.
*/
SELECT col1, col2, count(*)
FROM t1
GROUP BY col1, col2
HAVING count(*) > 1

/*
If there are only a few sets of duplicate PK values, the best procedure is to delete these manually on an individual basis. 
For example:
*/
set rowcount 1
delete from t1
where col1=1 and col2=1

IF EXISTS(SELECT name FROM sys.tables WHERE NAME = N't1')
DROP TABLE t1;
GO

create table t1(col1 int, col2 int, col3 char(50))
insert into t1 values (1, 1, 'data value one')
insert into t1 values (1, 1, 'data value one')
insert into t1 values (1, 2, 'data value two')
GO

SELECT * FROM t1;
GO

/*
1.First, run the above GROUP BY query to determine how many sets of duplicate PK values exist, and the count of duplicates for each set.
2.Select the duplicate key values into a holding table. For example:
*/

SELECT col1, col2, col3 = count(*)
INTO holdkey
FROM t1
GROUP BY col1, col2
HAVING count(*) > 1
GO

SELECT * FROM t1;
GO

/*				
 3.Select the duplicate rows into a holding table, eliminating duplicates in the process. For example:
*/

SELECT DISTINCT t1.*
INTO holddups
FROM t1, holdkey
WHERE t1.col1 = holdkey.col1
AND t1.col2 = holdkey.col2

SELECT * FROM t1;
GO

/*				
 4.At this point, the holddups table should have unique PKs, however, this will not be the case if t1 had duplicate PKs, yet unique rows (as in the SSN example above). Verify that each key in holddups is unique, and that you do not have duplicate keys, yet unique rows. If so, you must stop here and reconcile which of the rows you wish to keep for a given duplicate key value. For example, the query:
*/

SELECT col1, col2, count(*)
FROM holddups
GROUP BY col1, col2
/*
should return a count of 1 for each row. If yes, proceed to step 5 below. If no, you have duplicate keys, yet unique rows, and need to decide which rows to save. This will usually entail either discarding a row, or creating a new unique key value for this row. Take one of these two steps for each such duplicate PK in the holddups table.
*/

/*
5.Delete the duplicate rows from the original table. For example:
*/

SELECT * FROM t1;
GO

DELETE t1
FROM t1, holdkey
WHERE t1.col1 = holdkey.col1
AND t1.col2 = holdkey.col2

SELECT * FROM t1;
GO

/*				
 6.Put the unique rows back in the original table. For example:
*/

INSERT t1 SELECT * FROM holddups
GO

SELECT * FROM t1;
GO
