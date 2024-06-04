/******************************************************************************/

--Oracle

/******************************************************************************/

/*
Username: 
OracleHome
Password:
*********

Global database name:
orcl

[
Username: 
SYSTEM
]

Password:
************

Pluggable database name:
orclpdb
*/


--Git Bash
$ sqlplus -version
SQL*Plus: Release 12.2.0.1.0 Production
$ sqlplus -V
SQL*Plus: Release 12.2.0.1.0 Production
$ sqlplus SYSTEM/************
SQL> HELP INDEX
--OR
SQL> ? INDEX
SQL> QUIT
--OR
SQL> EXIT


--Command Line
> sqlplus -version
SQL*Plus: Release 12.2.0.1.0 Production
> sqlplus -V
SQL*Plus: Release 12.2.0.1.0 Production
> sqlplus SYSTEM/************
SQL> HELP INDEX
--OR
SQL> ? INDEX
SQL> QUIT
--OR
SQL> EXIT


$ sqlplus SYSTEM/************

[
$ sqlplus SYSTEM/************@orcl

$ sqlplus SYSTEM/************@localhost:1521/orcl
]

[
--CONNECT username/password
CONNECT SYSTEM/************

--CONNECT username/password@connect_identifier
CONNECT SYSTEM/************@orcl

--CONNECT username/password@[//]host[:port][/service_name]
CONNECT SYSTEM/************@localhost:1521/orcl
]

[
SQL> ? INDEX
SQL> HELP INDEX
SQL> SELECT owner, table_name FROM all_tables;
SQL> SELECT owner, table_name FROM dba_tables;
SQL> SELECT * from v$database;
SQL> SELECT * from gv$instance;
]

--Version
SELECT * FROM v$version;

--USER
SELECT user FROM DUAL;

--INSTANCE_NAME
SELECT sys_context('USERENV','INSTANCE_NAME') FROM DUAL;
--SID
SELECT sys_context('USERENV', 'SID') FROM DUAL;
--DB_NAME
SELECT sys_context('USERENV','DB_NAME') FROM DUAL;
--SERVICE_NAME
SELECT sys_context('USERENV','SERVICE_NAME') FROM DUAL;

--ORA_DATABASE_NAME
SELECT ora_database_name FROM DUAL;

--GLOBAL_NAME
SELECT * from global_name;

--Tables in USER
SELECT table_name FROM user_tables;

--DROP SEQUENCE seq_id;

CREATE SEQUENCE seq_id
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

--DROP TABLE users;

CREATE TABLE users
(
    id INT NOT NULL,
    username VARCHAR(50) NOT NULL, 
    login_date DATE NOT NULL,
    login_time VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT idx_username UNIQUE(username)    
);

COMMIT;

INSERT INTO users(id, username, login_date, login_time, created_at, updated_at)
VALUES
(
seq_id.nextval,
'Foo', 
TO_DATE('2016-11-06', 'YYYY-MM-DD'), 
'10:49:35', 
TO_TIMESTAMP('2016-11-06 10:49:35.0', 'YYYY-MM-DD HH:MI:SS.FF'), 
TO_TIMESTAMP('2016-11-06 10:49:35.0', 'YYYY-MM-DD HH:MI:SS.FF')
);

COMMIT;

SELECT * FROM users;

--Columns
[
SELECT * FROM ALL_TAB_COLUMNS WHERE  table_name = 'USERS';
SELECT * FROM USER_TAB_COLUMNS WHERE  table_name = 'USERS';
--OR
SELECT * FROM ALL_TAB_COLUMNS WHERE LOWER(table_name) = 'users';
SELECT * FROM USER_TAB_COLUMNS WHERE LOWER(table_name) = 'users';
--OR 
SELECT table_name, column_name, data_type, data_length FROM ALL_TAB_COLUMNS WHERE table_name = 'USERS';
SELECT table_name, column_name, data_type, data_length FROM USER_TAB_COLUMNS WHERE table_name = 'USERS';
--OR
SELECT table_name, column_name, data_type, data_length FROM ALL_TAB_COLUMNS WHERE LOWER(table_name) = 'users';
SELECT table_name, column_name, data_type, data_length FROM USER_TAB_COLUMNS WHERE LOWER(table_name) = 'users';
--OR
SELECT column_name FROM ALL_TAB_COLUMNS WHERE table_name = 'USERS';
SELECT column_name FROM USER_TAB_COLUMNS WHERE table_name = 'USERS';
]
SELECT column_name FROM ALL_TAB_COLUMNS WHERE LOWER(table_name) = 'users';
SELECT column_name FROM USER_TAB_COLUMNS WHERE LOWER(table_name) = 'users';


--DATE
SELECT SYSDATE FROM DUAL;
SELECT SYSTIMESTAMP FROM DUAL;

SELECT TO_DATE('2016-11-06', 'YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('2016-11-06 10:49:35', 'YYYY-MM-DD HH:MI:SS') FROM DUAL;

SELECT TO_CHAR(SYSDATE,'HH:MI:SS AM') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSTIMESTAMP,'HH:MI:SS AM') FROM DUAL;
SELECT TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(TO_DATE('2016-11-06 10:49:35', 'YYYY-MM-DD HH:MI:SS'), 'HH:MI:SS') FROM DUAL;

SELECT TO_TIMESTAMP('10-Sep-02 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF') FROM DUAL;
SELECT TO_TIMESTAMP('12:10:10', 'HH:MI:SS') FROM DUAL;
SELECT TO_TIMESTAMP('14:10:10', 'HH24:MI:SS') FROM DUAL;


[
--SQL Developer
--Connection Name
--sampledb 
Username:
SYSTEM
Password:
************

Hostname: localhost
Port: 1521
SID: orcl
]


[
--NoSQL
NoSQL_Connection
SYSTEM
************
localhost:5000
kvstore
]

/******************************************************************************/


--Credit
/*
https://oracle.com/
*/