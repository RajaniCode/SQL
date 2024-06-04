/******************************************************************************/

# MySQL # MariaDB

/******************************************************************************/

$ winpty mysqladmin --version
$ winpty mysql --version
$ winpty mysqlsh --version
> mysqladmin --version
> winpty mysql --version
> mysqlsh --version


# MySQL Shell
\connect --mysql root@localhost
# OR
$ winpty mysql -u root -p
> mysql -u root -p

# Queries
SELECT * FROM mysql.user\G

CREATE USER 'rajani'@'localhost' IDENTIFIED BY '**********************';

GRANT ALL PRIVILEGES ON * . * TO 'rajani'@'localhost';

SHOW GRANTS FOR 'rajani'@'localhost';

SELECT Host, User FROM mysql.user;

# \connect --mysql rajani@localhost
# CURRENT_USER()
SELECT CURRENT_USER();

# \connect --mysql root@localhost
# CURRENT_USER()
SELECT CURRENT_USER();

# ALTER ALTER USER 'rajani' # login as root or rajani
ALTER USER 'rajani'@'localhost' IDENTIFIED BY '***************';
# OR
# ALTER ALTER USER 'root' # login as root or rajani
ALTER USER 'root'@'localhost' IDENTIFIED BY '**********';

# \connect --mysql rajani@localhost
# CURRENT_USER()
SELECT CURRENT_USER();

# \connect --mysql root@localhost
# CURRENT_USER()
SELECT CURRENT_USER();

# DROP USER 'rajani' # login as root or rajani
DROP USER 'rajani'@'localhost';
# OR
# DROP USER 'root' # login as root or rajani
DROP USER 'root'@'localhost';

SELECT Host, User FROM mysql.user;

# Version
SELECT VERSION();
SELECT @@version;
SHOW VARIABLES LIKE "%version%";
SHOW GLOBAL VARIABLES LIKE '%version%';

# Databases
SHOW DATABASES;

# Change Database
USE `mysql`; # OR # USE `sys`;

# Current Database
SELECT DATABASE();
SELECT DATABASE() FROM DUAL;

# Tables/Views in Current Database
SHOW TABLES;

# Columns # Tables/Views
SELECT `COLUMN_NAME` 
FROM `INFORMATION_SCHEMA`.`COLUMNS` 
WHERE `TABLE_SCHEMA`='mysql' 
AND `TABLE_NAME`='db';
# OR
SELECT `COLUMN_NAME` 
FROM `INFORMATION_SCHEMA`.`COLUMNS` 
WHERE `TABLE_SCHEMA`='sys' 
AND `TABLE_NAME`='host_summary';

# Stored Procedures/Functions
SHOW PROCEDURE STATUS;
SHOW FUNCTION STATUS;

# USE `mysql`; # OR # USE `sys`;
# Check for sampledb # C:\Users\rajanis\Downloads\XAMPP\xampp\mysql\data
CREATE DATABASE IF NOT EXISTS `sampledb`;
# OR 
# DROP DATABASE IF EXISTS `sampledb`;
# CREATE DATABASE `sampledb`;

# Databases
SHOW DATABASES;

# USE `mysql`; # OR # USE `sys`;
DROP DATABASE IF EXISTS `sampledb`;

# Databases
SHOW DATABASES;

# USE `mysql`; # OR # USE `sys`;
# Again # Check for sampledb # C:\Users\rajanis\Downloads\XAMPP\xampp\mysql\data
CREATE DATABASE IF NOT EXISTS `sampledb`;

# Databases
SHOW DATABASES;

USE `sampledb`;

# Current Database
SELECT DATABASE();
SELECT DATABASE() FROM DUAL;

# DROP TABLE IF EXISTS `sampledb`.`sample_table`;

# MySQL ONLY # `updated_at` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
CREATE TABLE IF NOT EXISTS `sample_table`
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL, 
    `login_date` DATE NOT NULL,
    `login_time` TIME NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,    
    PRIMARY KEY(`id`),
    CONSTRAINT `idx_username` UNIQUE(`username`)    
);
# MariaDB # `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
/*
MariaDB automatically assigns the following properties to the column
DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP
# Warning (code 1280): Name 'pk_id' ignored for PRIMARY key.
*/
CREATE TABLE IF NOT EXISTS `sample_table`
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL, 
    `login_date` DATE NOT NULL,
    `login_time` TIME NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    PRIMARY KEY(`id`),
    CONSTRAINT `idx_username` UNIQUE(`username`)    
);
SELECT * FROM `sampledb`.`sample_table`;

# Tables/Views in Current Database
SHOW TABLES;

# Columns # Tables/Views # sampledb # sample_table
SELECT `COLUMN_NAME` 
FROM `INFORMATION_SCHEMA`.`COLUMNS` 
WHERE `TABLE_SCHEMA`='sampledb' 
AND `TABLE_NAME`='sample_table';

# AUTO_INCREMENT
SELECT AUTO_INCREMENT FROM 
information_schema.TABLES 
WHERE `TABLE_SCHEMA`='sampledb' 
AND `TABLE_NAME`='sample_table';

INSERT INTO `sampledb`.`sample_table`
(`username`, `login_date`, `login_time`, `created_at`, `updated_at`)
VALUES
('Foo', '2018-01-31', '22:58:57', '2018-01-20 21:57:56.0', '2018-01-31 22:58:57.0'),
('Bar', '2019-02-28', '23:59:58', '2019-01-27 22:58:57.0', '2019-02-28 23:59:58.0');
SELECT * FROM `sampledb`.`sample_table`;

# AUTO_INCREMENT 
SELECT AUTO_INCREMENT FROM 
information_schema.TABLES 
WHERE `TABLE_SCHEMA`='sampledb' 
AND `TABLE_NAME`='sample_table';

# MySQL ONLY # AUTO_INCREMENT # INSERT 
INSERT INTO `sample_table`  
(`id`, `username`, `login_date`, `login_time`, `created_at`, `updated_at`)
VALUES
(3, 'Baz', '2020-01-31', '22:58:57', '2020-01-20 21:57:56.0', '2020-01-31 22:58:57.0'),
(4, 'Qux', '2020-02-28', '23:59:58', '2020-01-27 22:58:57.0', '2020-02-28 23:59:58.0');
SELECT * FROM `sampledb`.`sample_table`;
# MariaDB # AUTO_INCREMENT # INSERT 
/*
'NO_AUTO_CREATE_USER' is deprecated in MySQL
*/
SET SQL_MODE='no_auto_value_on_zero';
INSERT INTO `sample_table`  
(`id`, `username`, `login_date`, `login_time`, `created_at`, `updated_at`)
VALUES
(3, 'Baz', '2020-01-31', '22:58:57', '2020-01-20 21:57:56.0', '2020-01-31 22:58:57.0'),
(4, 'Qux', '2020-02-28', '23:59:58', '2020-01-27 22:58:57.0', '2020-02-28 23:59:58.0');
SELECT * FROM `sampledb`.`sample_table`;

# AUTO_INCREMENT # Reset
ALTER TABLE sampledb.sample_table AUTO_INCREMENT = 10;

# AUTO_INCREMENT 
SELECT AUTO_INCREMENT FROM 
information_schema.TABLES 
WHERE `TABLE_SCHEMA`='sampledb' 
AND `TABLE_NAME`='sample_table';

INSERT INTO sample_table
SELECT 10, 'QUUX', '2021-01-31', '22:58:57', '2021-01-20 21:57:56.0', '2021-01-31 22:58:57.0'
UNION ALL
SELECT 11, 'QUUZ', '2021-02-28', '23:59:58', '2021-01-27 22:58:57.0', '2021-02-28 23:59:58.0';
SELECT * FROM `sampledb`.`sample_table`;

# @@tmpdir 
SELECT @@tmpdir;

# Export Table Data to CSV # CANNOT Overwrite # Specific Directory
# Note # D:/MySQLExport/CSV/sample_table_data.csv
# Warning (code 1287): '<select expression> INTO <destination>;' is deprecated and will be removed in a future release. Please use 'SELECT <select list> INTO <destination> FROM...' i
nstead
# SELECT * FROM `sampledb`.`sample_table` INTO OUTFILE 'D:/MySQLExport/CSV/sample_table_data.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
SELECT id, username, login_date, login_time, created_at, updated_at INTO OUTFILE 'D:/MySQLExport/CSV/sample_table_data.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' FROM `sampledb`.`sample_table`;


# MySQL Shell
/exit
# OR
/quit
# OR # XAMPP MySQL Shell
exit
# OR
quit




# Export Table Data to Console REPL
$ winpty mysql -u root -p -e "SELECT * FROM sampledb.sample_table;"
> mysql -u root -p -e "SELECT * FROM sampledb.sample_table;"

# Export Table Data to CSV # CANNOT Overwrite # Default Directory
$ winpty mysql -u root -p sampledb -e "SELECT * FROM sampledb.sample_table INTO OUTFILE 'sample_table_data.csv';"
$ cat "/C/Users/rajanis/Downloads/XAMPP/xampp/mysql/data/sampledb/sample_table_data.csv"
> mysql -u root -p sampledb -e "SELECT * FROM sampledb.sample_table INTO OUTFILE 'sample_table_data.csv';"
> type "C:\Users\rajanis\Downloads\XAMPP\xampp\mysql\data\sampledb\sample_table_data.csv"

# Export Table Data to CSV # CANNOT Overwrite # Specific Directory
$ mkdir -p "/D/MySQLExport/CSV"
> mkdir "D:\MySQLExport\CSV"
# Note # D:/MySQLExport/CSV/sample_table_data.csv
$ winpty mysql -u root -p sampledb -e "SELECT * FROM sampledb.sample_table INTO OUTFILE 'D:/MySQLExport/CSV/sample_table_data.csv';"
$ cat "/D/MySQLExport/CSV/sample_table_data.csv"
# Note # D:\\MySQLExport\\CSV\\sample_table_data.csv
> mysql -u root -p sampledb -e "SELECT * FROM sampledb.sample_table INTO OUTFILE 'D:\\MySQLExport\\CSV\\sample_table_data.csv';"
> type "D:\MySQLExport\CSV\sample_table_data.csv"

# Export Table Data to CSV # CANNOT Overwrite # ENCLOSED BY '"'
# Note # D:/MySQLExport/CSV/sample_table_data.csv
$ winpty mysql -u root -p sampledb -e "SELECT * FROM sampledb.sample_table INTO OUTFILE 'D:/MySQLExport/CSV/sample_table_data.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"
# Note # D:\\MySQLExport\\CSV\\sample_table_data.csv
> mysql -u root -p sampledb -e "SELECT * FROM sampledb.sample_table INTO OUTFILE 'D:\\MySQLExport\\CSV\\sample_table_data.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"




# MySQL $ winpty mysqlsh --version $ winpty mysqlsh --sql # \connect --mysql root@localhost
$ export PATH=$PATH:"/C/Users/rajanis/Downloads/MySQL/MySQL Shell/mysql-shell-8.0.25-windows-x86-64bit/bin/"

# XAMPP $ xampp-control $ xampp_start $ xampp_stop
# MySQL # MariaDB $ winpty mysqladmin --version $ winpty mysqladmin -u root password $ mysql_start.bat $ winpty mysql --version $ winpty mysql -u root -p $ mysql_stop.bat
$ export PATH=$PATH:"/C/Users/rajanis/Downloads/XAMPP/xampp/:/C/Users/rajanis/Downloads/XAMPP/xampp/mysql/bin/"


# MySQL > mysqlsh --version > mysqlsh --sql # \connect --mysql root@localhost
> set path=%path%;C:\Users\rajanis\Downloads\MySQL\MySQL Shell\mysql-shell-8.0.25-windows-x86-64bit\bin\

# XAMPP > xampp-control > xampp_start > xampp_stop
# MySQL # MariaDB > mysqladmin --version > mysqladmin -u root password > mysql_start.bat > mysql --version > mysql -u root -p > mysql_stop.bat
> set path=%path%;C:\Users\rajanis\Downloads\XAMPP\xampp\;C:\Users\rajanis\Downloads\XAMPP\xampp\mysql\bin\


# Data: C:\Users\rajanis\Downloads\XAMPP\xampp\mysql\data


[
$ winpty mysqladmin -u root proc stat
$ winpty mysqladmin -u root password
New password: **********
Confirm new password: **********

> mysqladmin -u root password
> New password: **********
> Confirm new password: **********

# Azure # <Azure domain name> # OR # <Azure domain IP address> 
$ winpty mysqlsh --sql # \connect --mysql <user>@<Azure domain name>
> mysqlsh --sql # \connect --mysql <user>@<Azure domain name>
# OR
$ winpty mysql -h <Azure domain name> -u sampledb --ssl -p
> mysql -h <Azure domain name> -u sampledb --ssl -p
]



$ export PATH=$PATH:"/C/Users/rajanis/Downloads/XAMPP/xampp/:/C/Users/rajanis/Downloads/XAMPP/xampp/mysql/bin/"

$ winpty mysqladmin --version
C:/Users/rajanis/Downloads/XAMPP/xampp/mysql/bin/mysqladmin.exe  Ver 9.1 Distrib 10.4.14-MariaDB, for Win64 on AMD64

$ winpty mysql --version
C:/Users/rajanis/Downloads/XAMPP/xampp/mysql/bin/mysql.exe  Ver 15.1 Distrib 10.4.14-MariaDB, for Win64 (AMD64), source revision ddffcad64c9ff3299037eed9df1bc92d51f8d07e

$ export PATH=$PATH:"/C/Users/rajanis/Downloads/MySQL/MySQL Shell/mysql-shell-8.0.25-windows-x86-64bit/bin/"

$ winpty mysqlsh --version
C:/Users/rajanis/Downloads/MySQL/MySQL Shell/mysql-shell-8.0.25-windows-x86-64bit/bin/mysqlsh.exe   Ver 8.0.25 for Win64 on x86_64 - for MySQL 8.0.25 (MySQL Community Server (GPL))

$ winpty mysqlsh --sql
MySQL Shell 8.0.25

Copyright (c) 2016, 2021, Oracle and/or its affiliates.
Oracle is a registered trademark of Oracle Corporation and/or its affiliates.
Other names may be trademarks of their respective owners.

Type '\help' or '\?' for help; '\quit' to exit.
 MySQL  SQL > \?
The Shell Help is organized in categories and topics. To get help for a
specific category or topic use: \? <pattern>

The <pattern> argument should be the name of a category or a topic.

The pattern is a filter to identify topics for which help is required, it can
use the following wildcards:

- ? matches any single character.
- * matches any character sequence.

The following are the main help categories:

 - Shell Commands Provides details about the available built-in shell commands.
 - SQL Syntax     Entry point to retrieve syntax help on SQL statements.

The available topics include:

- The available shell commands.
- Any word that is part of an SQL statement.
- Command Line - invoking built-in shell functions without entering interactive
  mode.

SHELL COMMANDS

The shell commands allow executing specific operations including updating the
shell configuration.

The following shell commands are available:

 - \                   Start multi-line input when in SQL mode.
 - \connect    (\c)    Connects the shell to a MySQL server and assigns the
                       global session.
 - \disconnect         Disconnects the global session.
 - \edit       (\e)    Launch a system editor to edit a command to be executed.
 - \exit               Exits the MySQL Shell, same as \quit.
 - \G                  Send command to mysql server, display result vertically.
 - \g                  Send command to mysql server.
 - \help       (\?,\h) Prints help information about a specific topic.
 - \history            View and edit command line history.
 - \js                 Switches to JavaScript processing mode.
 - \nopager            Disables the current pager.
 - \nowarnings (\w)    Don't show warnings after every statement.
 - \option             Allows working with the available shell options.
 - \pager      (\P)    Sets the current pager.
 - \py                 Switches to Python processing mode.
 - \quit       (\q)    Exits the MySQL Shell.
 - \reconnect          Reconnects the global session.
 - \rehash             Refresh the autocompletion cache.
 - \show               Executes the given report with provided options and
                       arguments.
 - \source     (\.)    Loads and executes a script from a file.
 - \sql                Executes SQL statement or switches to SQL processing
                       mode when no statement is given.
 - \status     (\s)    Print information about the current global session.
 - \system     (\!)    Execute a system shell command.
 - \use        (\u)    Sets the active schema.
 - \warnings   (\W)    Show warnings after every statement.
 - \watch              Executes the given report with provided options and
                       arguments in a loop.

EXAMPLES
\? sql syntax
      Displays the main SQL help categories.

\? select
      Displays information about the SELECT SQL statement.
 MySQL  SQL > \connect --mysql root@localhost
Creating a Classic session to 'root@localhost'
Please provide the password for 'root@localhost': **********
Save password for 'root@localhost'? [Y]es/[N]o/Ne[v]er (default No): v
Fetching schema names for autocompletion... Press ^C to stop.
Your MySQL connection id is 8
Server version: 10.4.14-MariaDB mariadb.org binary distribution
No default schema selected; type \use <schema> to set one.
 MySQL  localhost:3306  SQL > SELECT * FROM mysql.user\G
*************************** 1. row ***************************
                  Host: localhost
                  User: root
              Password: *2196B3F553BEA900D04572FDC220256FB63DAFA6
           Select_priv: Y
           Insert_priv: Y
           Update_priv: Y
           Delete_priv: Y
           Create_priv: Y
             Drop_priv: Y
           Reload_priv: Y
         Shutdown_priv: Y
          Process_priv: Y
             File_priv: Y
            Grant_priv: Y
       References_priv: Y
            Index_priv: Y
            Alter_priv: Y
          Show_db_priv: Y
            Super_priv: Y
 Create_tmp_table_priv: Y
      Lock_tables_priv: Y
          Execute_priv: Y
       Repl_slave_priv: Y
      Repl_client_priv: Y
      Create_view_priv: Y
        Show_view_priv: Y
   Create_routine_priv: Y
    Alter_routine_priv: Y
      Create_user_priv: Y
            Event_priv: Y
          Trigger_priv: Y
Create_tablespace_priv: Y
   Delete_history_priv: Y
              ssl_type:
            ssl_cipher:
           x509_issuer:
          x509_subject:
         max_questions: 0
           max_updates: 0
       max_connections: 0
  max_user_connections: 0
                plugin: mysql_native_password
 authentication_string: *2196B3F553BEA900D04572FDC220256FB63DAFA6
      password_expired: N
               is_role: N
          default_role:
    max_statement_time: 0.000000
*************************** 2. row ***************************
                  Host: 127.0.0.1
                  User: root
              Password:
           Select_priv: Y
           Insert_priv: Y
           Update_priv: Y
           Delete_priv: Y
           Create_priv: Y
             Drop_priv: Y
           Reload_priv: Y
         Shutdown_priv: Y
          Process_priv: Y
             File_priv: Y
            Grant_priv: Y
       References_priv: Y
            Index_priv: Y
            Alter_priv: Y
          Show_db_priv: Y
            Super_priv: Y
 Create_tmp_table_priv: Y
      Lock_tables_priv: Y
          Execute_priv: Y
       Repl_slave_priv: Y
      Repl_client_priv: Y
      Create_view_priv: Y
        Show_view_priv: Y
   Create_routine_priv: Y
    Alter_routine_priv: Y
      Create_user_priv: Y
            Event_priv: Y
          Trigger_priv: Y
Create_tablespace_priv: Y
   Delete_history_priv: Y
              ssl_type:
            ssl_cipher:
           x509_issuer:
          x509_subject:
         max_questions: 0
           max_updates: 0
       max_connections: 0
  max_user_connections: 0
                plugin:
 authentication_string:
      password_expired: N
               is_role: N
          default_role:
    max_statement_time: 0.000000
*************************** 3. row ***************************
                  Host: ::1
                  User: root
              Password:
           Select_priv: Y
           Insert_priv: Y
           Update_priv: Y
           Delete_priv: Y
           Create_priv: Y
             Drop_priv: Y
           Reload_priv: Y
         Shutdown_priv: Y
          Process_priv: Y
             File_priv: Y
            Grant_priv: Y
       References_priv: Y
            Index_priv: Y
            Alter_priv: Y
          Show_db_priv: Y
            Super_priv: Y
 Create_tmp_table_priv: Y
      Lock_tables_priv: Y
          Execute_priv: Y
       Repl_slave_priv: Y
      Repl_client_priv: Y
      Create_view_priv: Y
        Show_view_priv: Y
   Create_routine_priv: Y
    Alter_routine_priv: Y
      Create_user_priv: Y
            Event_priv: Y
          Trigger_priv: Y
Create_tablespace_priv: Y
   Delete_history_priv: Y
              ssl_type:
            ssl_cipher:
           x509_issuer:
          x509_subject:
         max_questions: 0
           max_updates: 0
       max_connections: 0
  max_user_connections: 0
                plugin:
 authentication_string:
      password_expired: N
               is_role: N
          default_role:
    max_statement_time: 0.000000
*************************** 4. row ***************************
                  Host: localhost
                  User: pma
              Password:
           Select_priv: N
           Insert_priv: N
           Update_priv: N
           Delete_priv: N
           Create_priv: N
             Drop_priv: N
           Reload_priv: N
         Shutdown_priv: N
          Process_priv: N
             File_priv: N
            Grant_priv: N
       References_priv: N
            Index_priv: N
            Alter_priv: N
          Show_db_priv: N
            Super_priv: N
 Create_tmp_table_priv: N
      Lock_tables_priv: N
          Execute_priv: N
       Repl_slave_priv: N
      Repl_client_priv: N
      Create_view_priv: N
        Show_view_priv: N
   Create_routine_priv: N
    Alter_routine_priv: N
      Create_user_priv: N
            Event_priv: N
          Trigger_priv: N
Create_tablespace_priv: N
   Delete_history_priv: N
              ssl_type:
            ssl_cipher:
           x509_issuer:
          x509_subject:
         max_questions: 0
           max_updates: 0
       max_connections: 0
  max_user_connections: 0
                plugin: mysql_native_password
 authentication_string:
      password_expired: N
               is_role: N
          default_role:
    max_statement_time: 0.000000
4 rows in set (0.0067 sec)
 MySQL  localhost:3306  SQL > SELECT Host, User FROM mysql.user;
+-----------+--------+
| Host      | User   |
+-----------+--------+
| 127.0.0.1 | root   |
| ::1       | root   |
| localhost | pma    |
| localhost | root   |
+-----------+--------+
4 rows in set (0.0013 sec)
 MySQL  localhost:3306  SQL > CREATE USER 'rajani'@'localhost' IDENTIFIED BY '**********************';	                      
Query OK, 0 rows affected (0.0204 sec)
 MySQL  localhost:3306  SQL > GRANT ALL PRIVILEGES ON * . * TO 'rajani'@'localhost';
Query OK, 0 rows affected (0.0104 sec)
 MySQL  localhost:3306  SQL > SHOW GRANTS FOR 'rajani'@'localhost';
+------------------------------------------------------------------------------------------------------------------------+
| Grants for rajani@localhost                                                                                            |
+------------------------------------------------------------------------------------------------------------------------+
| GRANT ALL PRIVILEGES ON *.* TO `rajani`@`localhost` IDENTIFIED BY PASSWORD '*B1B34EE4FEDB43191D88FEE7ADD723149736407B' |
+------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  SQL > SELECT Host, User FROM mysql.user;
+-----------+--------+
| Host      | User   |
+-----------+--------+
| 127.0.0.1 | root   |
| ::1       | root   |
| localhost | pma    |
| localhost | rajani |
| localhost | root   |
+-----------+--------+
5 rows in set (0.0013 sec)
 MySQL  localhost:3306  SQL > \connect --mysql rajani@localhost
Creating a Classic session to 'rajani@localhost'
Please provide the password for 'rajani@localhost': **********************
Save password for 'rajani@localhost'? [Y]es/[N]o/Ne[v]er (default No): v
Fetching schema names for autocompletion... Press ^C to stop.
Closing old connection...
Your MySQL connection id is 9
Server version: 10.4.14-MariaDB mariadb.org binary distribution
No default schema selected; type \use <schema> to set one.
 MySQL  localhost:3306  SQL > SELECT CURRENT_USER();
+------------------+
| CURRENT_USER()   |
+------------------+
| rajani@localhost |
+------------------+
1 row in set (0.0195 sec)
 MySQL  localhost:3306  SQL > \connect --mysql root@localhost
Creating a Classic session to 'root@localhost'
Please provide the password for 'root@localhost': **********
Fetching schema names for autocompletion... Press ^C to stop.
Closing old connection...
Your MySQL connection id is 10
Server version: 10.4.14-MariaDB mariadb.org binary distribution
No default schema selected; type \use <schema> to set one.
 MySQL  localhost:3306  SQL > SELECT CURRENT_USER();
+----------------+
| CURRENT_USER() |
+----------------+
| root@localhost |
+----------------+
1 row in set (0.0001 sec)
 MySQL  localhost:3306  SQL > ALTER USER 'rajani'@'localhost' IDENTIFIED BY '***************';	                      
Query OK, 0 rows affected (0.0184 sec)
 MySQL  localhost:3306  SQL > \connect --mysql rajani@localhost
Creating a Classic session to 'rajani@localhost'
Please provide the password for 'rajani@localhost': ***************
Save password for 'rajani@localhost'? [Y]es/[N]o/Ne[v]er (default No): v
Fetching schema names for autocompletion... Press ^C to stop.
Closing old connection...
Your MySQL connection id is 9
Server version: 10.4.14-MariaDB mariadb.org binary distribution
No default schema selected; type \use <schema> to set one.
 MySQL  localhost:3306  SQL > SELECT CURRENT_USER();
+------------------+
| CURRENT_USER()   |
+------------------+
| rajani@localhost |
+------------------+
1 row in set (0.0195 sec)
 MySQL  localhost:3306  SQL > \connect --mysql root@localhost
Creating a Classic session to 'root@localhost'
Please provide the password for 'root@localhost': **********
Fetching schema names for autocompletion... Press ^C to stop.
Closing old connection...
Your MySQL connection id is 10
Server version: 10.4.14-MariaDB mariadb.org binary distribution
No default schema selected; type \use <schema> to set one.
 MySQL  localhost:3306  SQL > SELECT CURRENT_USER();
+----------------+
| CURRENT_USER() |
+----------------+
| root@localhost |
+----------------+
1 row in set (0.0001 sec)
 MySQL  localhost:3306  SQL > DROP USER 'rajani'@'localhost';
Query OK, 0 rows affected (0.0108 sec)
 MySQL  localhost:3306  SQL > SELECT Host, User FROM mysql.user;
+-----------+------+
| Host      | User |
+-----------+------+
| 127.0.0.1 | root |
| ::1       | root |
| localhost | pma  |
| localhost | root |
+-----------+------+
4 rows in set (0.0012 sec)
 MySQL  localhost:3306  SQL > SELECT VERSION();
+-----------------+
| VERSION()       |
+-----------------+
| 10.4.14-MariaDB |
+-----------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  SQL > SELECT @@version;
+-----------------+
| @@version       |
+-----------------+
| 10.4.14-MariaDB |
+-----------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  SQL > SHOW VARIABLES LIKE "%version%";
+-----------------------------------+------------------------------------------+
| Variable_name                     | Value                                    |
+-----------------------------------+------------------------------------------+
| in_predicate_conversion_threshold | 1000                                     |
| innodb_version                    | 10.4.14                                  |
| protocol_version                  | 10                                       |
| slave_type_conversions            |                                          |
| system_versioning_alter_history   | ERROR                                    |
| system_versioning_asof            | DEFAULT                                  |
| tls_version                       | TLSv1.1,TLSv1.2,TLSv1.3                  |
| version                           | 10.4.14-MariaDB                          |
| version_comment                   | mariadb.org binary distribution          |
| version_compile_machine           | x64                                      |
| version_compile_os                | Win64                                    |
| version_malloc_library            | system                                   |
| version_source_revision           | ddffcad64c9ff3299037eed9df1bc92d51f8d07e |
| version_ssl_library               | WolfSSL 4.4.0                            |
+-----------------------------------+------------------------------------------+
14 rows in set (0.0009 sec)
 MySQL  localhost:3306  SQL > SHOW GLOBAL VARIABLES LIKE '%version%';
+-----------------------------------+------------------------------------------+
| Variable_name                     | Value                                    |
+-----------------------------------+------------------------------------------+
| in_predicate_conversion_threshold | 1000                                     |
| innodb_version                    | 10.4.14                                  |
| protocol_version                  | 10                                       |
| slave_type_conversions            |                                          |
| system_versioning_alter_history   | ERROR                                    |
| system_versioning_asof            | DEFAULT                                  |
| tls_version                       | TLSv1.1,TLSv1.2,TLSv1.3                  |
| version                           | 10.4.14-MariaDB                          |
| version_comment                   | mariadb.org binary distribution          |
| version_compile_machine           | x64                                      |
| version_compile_os                | Win64                                    |
| version_malloc_library            | system                                   |
| version_source_revision           | ddffcad64c9ff3299037eed9df1bc92d51f8d07e |
| version_ssl_library               | WolfSSL 4.4.0                            |
+-----------------------------------+------------------------------------------+
14 rows in set (0.0009 sec)
 MySQL  localhost:3306  SQL > SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| customerdb         |
| information_schema |
| mysql              |
| performance_schema |
| phpmyadmin         |
| test               |
+--------------------+
6 rows in set (0.0009 sec)
 MySQL  localhost:3306  SQL > USE `mysql`;
Default schema set to `mysql`.
Fetching table and column names from `mysql` for auto-completion... Press ^C to stop.
Error during auto-completion cache update: Table 'mysql.gtid_slave_pos' doesn't exist in engine
 MySQL  localhost:3306  mysql  SQL > SELECT DATABASE();
+------------+
| DATABASE() |
+------------+
| mysql      |
+------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  mysql  SQL > SELECT DATABASE() FROM DUAL;
+------------+
| DATABASE() |
+------------+
| mysql      |
+------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  mysql  SQL > SHOW TABLES;
+---------------------------+
| Tables_in_mysql           |
+---------------------------+
| column_stats              |
| columns_priv              |
| db                        |
| event                     |
| func                      |
| general_log               |
| global_priv               |
| gtid_slave_pos            |
| help_category             |
| help_keyword              |
| help_relation             |
| help_topic                |
| index_stats               |
| innodb_index_stats        |
| innodb_table_stats        |
| plugin                    |
| proc                      |
| procs_priv                |
| proxies_priv              |
| roles_mapping             |
| servers                   |
| slow_log                  |
| table_stats               |
| tables_priv               |
| time_zone                 |
| time_zone_leap_second     |
| time_zone_name            |
| time_zone_transition      |
| time_zone_transition_type |
| transaction_registry      |
| user                      |
+---------------------------+
31 rows in set (0.0010 sec)
 MySQL  localhost:3306  mysql  SQL > SELECT `COLUMN_NAME`
                                  -> FROM `INFORMATION_SCHEMA`.`COLUMNS`
                                  -> WHERE `TABLE_SCHEMA`='mysql'
                                  -> AND `TABLE_NAME`='db';
+-----------------------+
| COLUMN_NAME           |
+-----------------------+
| Host                  |
| Db                    |
| User                  |
| Select_priv           |
| Insert_priv           |
| Update_priv           |
| Delete_priv           |
| Create_priv           |
| Drop_priv             |
| Grant_priv            |
| References_priv       |
| Index_priv            |
| Alter_priv            |
| Create_tmp_table_priv |
| Lock_tables_priv      |
| Create_view_priv      |
| Show_view_priv        |
| Create_routine_priv   |
| Alter_routine_priv    |
| Execute_priv          |
| Event_priv            |
| Trigger_priv          |
| Delete_history_priv   |
+-----------------------+
23 rows in set (0.0094 sec)
 MySQL  localhost:3306  sampledb  SQL > SHOW PROCEDURE STATUS;
Empty set (0.0135 sec)
 MySQL  localhost:3306  sampledb  SQL > SHOW FUNCTION STATUS;
Empty set (0.0051 sec)
 MySQL  localhost:3306  sampledb  SQL > CREATE DATABASE IF NOT EXISTS `sampledb`;
Query OK, 1 row affected (0.0105 sec)
 MySQL  localhost:3306  sampledb  SQL > SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| customerdb         |
| information_schema |
| mysql              |
| performance_schema |
| phpmyadmin         |
| sampledb           |
| test               |
+--------------------+
7 rows in set (0.0010 sec)
 MySQL  localhost:3306  sampledb  SQL > DROP DATABASE IF EXISTS `sampledb`;
Query OK, 0 rows affected (0.0022 sec)
 MySQL  localhost:3306  sampledb  SQL > SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| customerdb         |
| information_schema |
| mysql              |
| performance_schema |
| phpmyadmin         |
| test               |
+--------------------+
6 rows in set (0.0011 sec)
 MySQL  localhost:3306  sampledb  SQL > CREATE DATABASE IF NOT EXISTS `sampledb`;
Query OK, 1 row affected (0.0015 sec)
 MySQL  localhost:3306  sampledb  SQL > SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| customerdb         |
| information_schema |
| mysql              |
| performance_schema |
| phpmyadmin         |
| sampledb           |
| test               |
+--------------------+
7 rows in set (0.0008 sec)
 MySQL  localhost:3306  sampledb  SQL > USE `sampledb`;
Default schema set to `sampledb`.
Fetching table and column names from `sampledb` for auto-completion... Press ^C to stop.
 MySQL  localhost:3306  sampledb  SQL > SELECT DATABASE();
+------------+
| DATABASE() |
+------------+
| sampledb   |
+------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT DATABASE() FROM DUAL;
+------------+
| DATABASE() |
+------------+
| sampledb   |
+------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > CREATE TABLE IF NOT EXISTS `sample_table`
                                     -> (
                                     ->     `id` INT NOT NULL AUTO_INCREMENT,
                                     ->     `username` VARCHAR(50) NOT NULL,
                                     ->     `login_date` DATE NOT NULL,
                                     ->     `login_time` TIME NOT NULL,
                                     ->     `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                     ->     `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                     ->     PRIMARY KEY(`id`),
                                     ->     CONSTRAINT `idx_username` UNIQUE(`username`)
                                     -> );
Query OK, 0 rows affected (0.0181 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT * FROM `sampledb`.`sample_table`;
Empty set (0.0040 sec)
 MySQL  localhost:3306  sampledb  SQL > SHOW TABLES;
+--------------------+
| Tables_in_sampledb |
+--------------------+
| sample_table       |
+--------------------+
1 row in set (0.0007 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT `COLUMN_NAME`
                                     -> FROM `INFORMATION_SCHEMA`.`COLUMNS`
                                     -> WHERE `TABLE_SCHEMA`='sampledb'
                                     -> AND `TABLE_NAME`='sample_table';
+-------------+
| COLUMN_NAME |
+-------------+
| id          |
| username    |
| login_date  |
| login_time  |
| created_at  |
| updated_at  |
+-------------+
6 rows in set (0.0004 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT AUTO_INCREMENT FROM
                                     -> information_schema.TABLES
                                     -> WHERE `TABLE_SCHEMA`='sampledb'
                                     -> AND `TABLE_NAME`='sample_table';
+----------------+
| AUTO_INCREMENT |
+----------------+
|              1 |
+----------------+
1 row in set (0.0006 sec)
 MySQL  localhost:3306  sampledb  SQL > INSERT INTO `sampledb`.`sample_table`
                                     -> (`username`, `login_date`, `login_time`, `created_at`, `updated_at`)
                                     -> VALUES
                                     -> ('Foo', '2018-01-31', '22:58:57', '2018-01-20 21:57:56.0', '2018-01-31 22:58:57.0'),
                                     -> ('Bar', '2019-02-28', '23:59:58', '2019-01-27 22:58:57.0', '2019-02-28 23:59:58.0');
Query OK, 2 rows affected (0.0126 sec)

Records: 2  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306  sampledb  SQL > SELECT * FROM `sampledb`.`sample_table`;
+----+----------+------------+------------+---------------------+---------------------+
| id | username | login_date | login_time | created_at          | updated_at          |
+----+----------+------------+------------+---------------------+---------------------+
|  1 | Foo      | 2018-01-31 | 22:58:57   | 2018-01-20 21:57:56 | 2018-01-31 22:58:57 |
|  2 | Bar      | 2019-02-28 | 23:59:58   | 2019-01-27 22:58:57 | 2019-02-28 23:59:58 |
+----+----------+------------+------------+---------------------+---------------------+
2 rows in set (0.0004 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT AUTO_INCREMENT FROM
                                     -> information_schema.TABLES
                                     -> WHERE `TABLE_SCHEMA`='sampledb'
                                     -> AND `TABLE_NAME`='sample_table';
+----------------+
| AUTO_INCREMENT |
+----------------+
|              3 |
+----------------+
1 row in set (0.0005 sec)
 MySQL  localhost:3306  sampledb  SQL > SET SQL_MODE='no_auto_value_on_zero';
Query OK, 0 rows affected (0.0212 sec)
 MySQL  localhost:3306  sampledb  SQL > INSERT INTO `sample_table`
                                     -> (`id`, `username`, `login_date`, `login_time`, `created_at`, `updated_at`)
                                     -> VALUES
                                     -> (3, 'Baz', '2020-01-31', '22:58:57', '2020-01-20 21:57:56.0', '2020-01-31 22:58:57.0'),
                                     -> (4, 'Qux', '2020-02-28', '23:59:58', '2020-01-27 22:58:57.0', '2020-02-28 23:59:58.0');
Query OK, 2 rows affected (0.0128 sec)

Records: 2  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306  sampledb  SQL > SELECT * FROM `sampledb`.`sample_table`;
+----+----------+------------+------------+---------------------+---------------------+
| id | username | login_date | login_time | created_at          | updated_at          |
+----+----------+------------+------------+---------------------+---------------------+
|  1 | Foo      | 2018-01-31 | 22:58:57   | 2018-01-20 21:57:56 | 2018-01-31 22:58:57 |
|  2 | Bar      | 2019-02-28 | 23:59:58   | 2019-01-27 22:58:57 | 2019-02-28 23:59:58 |
|  3 | Baz      | 2020-01-31 | 22:58:57   | 2020-01-20 21:57:56 | 2020-01-31 22:58:57 |
|  4 | Qux      | 2020-02-28 | 23:59:58   | 2020-01-27 22:58:57 | 2020-02-28 23:59:58 |
+----+----------+------------+------------+---------------------+---------------------+
4 rows in set (0.0005 sec)
 MySQL  localhost:3306  sampledb  SQL > ALTER TABLE sampledb.sample_table AUTO_INCREMENT = 10;
Query OK, 0 rows affected (0.0170 sec)

Records: 0  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306  sampledb  SQL > SELECT AUTO_INCREMENT FROM
                                     -> information_schema.TABLES
                                     -> WHERE `TABLE_SCHEMA`='sampledb'
                                     -> AND `TABLE_NAME`='sample_table';
+----------------+
| AUTO_INCREMENT |
+----------------+
|             10 |
+----------------+
1 row in set (0.0005 sec)
 MySQL  localhost:3306  sampledb  SQL > INSERT INTO sample_table
                                     -> SELECT 10, 'QUUX', '2021-01-31', '22:58:57', '2021-01-20 21:57:56.0', '2021-01-31 22:58:57.0'
                                     -> UNION ALL
                                     -> SELECT 11, 'QUUZ', '2021-02-28', '23:59:58', '2021-01-27 22:58:57.0', '2021-02-28 23:59:58.0';
Query OK, 2 rows affected (0.0114 sec)

Records: 2  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306  sampledb  SQL > SELECT * FROM `sampledb`.`sample_table`;
+----+----------+------------+------------+---------------------+---------------------+
| id | username | login_date | login_time | created_at          | updated_at          |
+----+----------+------------+------------+---------------------+---------------------+
|  1 | Foo      | 2018-01-31 | 22:58:57   | 2018-01-20 21:57:56 | 2018-01-31 22:58:57 |
|  2 | Bar      | 2019-02-28 | 23:59:58   | 2019-01-27 22:58:57 | 2019-02-28 23:59:58 |
|  3 | Baz      | 2020-01-31 | 22:58:57   | 2020-01-20 21:57:56 | 2020-01-31 22:58:57 |
|  4 | Qux      | 2020-02-28 | 23:59:58   | 2020-01-27 22:58:57 | 2020-02-28 23:59:58 |
| 10 | QUUX     | 2021-01-31 | 22:58:57   | 2021-01-20 21:57:56 | 2021-01-31 22:58:57 |
| 11 | QUUZ     | 2021-02-28 | 23:59:58   | 2021-01-27 22:58:57 | 2021-02-28 23:59:58 |
+----+----------+------------+------------+---------------------+---------------------+
6 rows in set (0.0004 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT @@tmpdir;
+------------------------------------------+
| @@tmpdir                                 |
+------------------------------------------+
| /Users/rajanis/Downloads/XAMPP/xampp/tmp |
+------------------------------------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT id, username, login_date, login_time, created_at, updated_at INTO OUTFILE 'D:/MySQLExport/CSV/sample_table_data.csv' FIELDS TERMINATE
D BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' FROM `sampledb`.`sample_table`;
Query OK, 6 rows affected (0.0021 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT CURDATE();
+------------+
| CURDATE()  |
+------------+
| 2021-07-31 |
+------------+
1 row in set (0.0005 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT CURRENT_DATE();
+----------------+
| CURRENT_DATE() |
+----------------+
| 2021-07-31     |
+----------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT CURRENT_DATE;
+--------------+
| CURRENT_DATE |
+--------------+
| 2021-07-31   |
+--------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT CURRENT_TIME();
+----------------+
| CURRENT_TIME() |
+----------------+
| 03:08:02       |
+----------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT CURRENT_TIME;
+--------------+
| CURRENT_TIME |
+--------------+
| 03:08:19     |
+--------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT CURRENT_TIMESTAMP();
+---------------------+
| CURRENT_TIMESTAMP() |
+---------------------+
| 2021-07-31 03:08:26 |
+---------------------+
1 row in set (0.0004 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT CURRENT_TIMESTAMP;
+---------------------+
| CURRENT_TIMESTAMP   |
+---------------------+
| 2021-07-31 03:08:33 |
+---------------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT CURTIME();
+-----------+
| CURTIME() |
+-----------+
| 03:08:40  |
+-----------+
1 row in set (0.0103 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT LOCALTIME;
+---------------------+
| LOCALTIME           |
+---------------------+
| 2021-07-31 03:08:47 |
+---------------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT LOCALTIMESTAMP();
+---------------------+
| LOCALTIMESTAMP()    |
+---------------------+
| 2021-07-31 03:08:55 |
+---------------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT LOCALTIMESTAMP;
+---------------------+
| LOCALTIMESTAMP      |
+---------------------+
| 2021-07-31 03:09:07 |
+---------------------+
1 row in set (0.0005 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT NOW();
+---------------------+
| NOW()               |
+---------------------+
| 2021-07-31 03:09:13 |
+---------------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT SYSDATE();
+---------------------+
| SYSDATE()           |
+---------------------+
| 2021-07-31 03:09:19 |
+---------------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT UNIX_TIMESTAMP();
+------------------+
| UNIX_TIMESTAMP() |
+------------------+
|       1627681167 |
+------------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT UTC_DATE();
+------------+
| UTC_DATE() |
+------------+
| 2021-07-30 |
+------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT UTC_TIME();
+------------+
| UTC_TIME() |
+------------+
| 21:39:41   |
+------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > SELECT UTC_TIMESTAMP();
+---------------------+
| UTC_TIMESTAMP()     |
+---------------------+
| 2021-07-30 21:39:49 |
+---------------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306  sampledb  SQL > \exit
Bye!

/******************************************************************************/


# Credits
/*
https://mysql.com/
https://mariadb.org/
*/