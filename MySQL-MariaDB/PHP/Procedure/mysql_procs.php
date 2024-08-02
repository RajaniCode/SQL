<?php

# PHP CLI
# $ cd "E:\Working\SQL\MySQL\PHP\Procedure"
# $ php -S 0.0.0.0:8080
# http://localhost:8080/mysql_procs.php
# XAMPP Apache
# http://localhost:88/mysql_procs.php
# C:\xampp\apache\conf\httpd.conf
# Listen 88
# # Virtual hosts
# Include conf/extra/httpd-vhosts.conf
# C:\xampp\apache\conf\extra\httpd-vhosts.conf
/* 
<VirtualHost *:88>
    ServerName mysqlapp.localhost
    DocumentRoot E:/Working/SQL/MySQL/PHP/Procedure
    SetEnv APPLICATION_ENV "development"
    <Directory E:/Working/SQL/MySQL/PHP/Procedure>
        DirectoryIndex index.php
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
*/

/*
# Note
services.msc
Start MySQL
Start XAMPP Apache
Stop XAMPP MySQL
http://localhost/phpmyadmin
# OR
http://localhost:88/phpmyadmin
*/

# MySQL 
$host = 'localhost';
$username = 'root';
// mysql://localhost:3306  ## http://localhost/phpmyadmin
$password = 'My$ql@Server#5.7'; ##
$dbname = 'procdb'; ## $dbname = 'phpprocdb';

function exception_error_handler($errno, $errstr, $errfile, $errline ) {
    throw new ErrorException($errstr, $errno, 0, $errfile, $errline);
}

set_error_handler("exception_error_handler");

try {
    echo "Connecting to MySQL database..." . "\n";
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password); ##
    ## $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username);
    
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    echo "Connected to MySQL Server successfully." . "\n";
   
    $sql = "CALL multiply(5, 5, @Result);"; 
    $pdo->query($sql);
    $sql = "SELECT @Result;"; 
    $rows = $pdo->query($sql);
    foreach($rows as $row) {
      echo $row['@Result'] . "\n";
    }
    $sql = "CALL concat('My', 'SQL', @Result);"; 
    $pdo->query($sql);
    $sql = "SELECT @Result;"; 
    $rows = $pdo->query($sql);
    foreach($rows as $row) {
      echo $row['@Result'] . "\n";
    }  
} catch (PDOException $e) {
    #die("Could not connect to the database $dbname :" . $e->getMessage());
    $error = $e->getMessage();
    echo $error . "\n";
} catch (Exception $e) {
    $error = $e->getMessage();
    echo $error . "\n";
} finally {
    $pdo = null;
    echo "Connection closed." . "\n";
}


/*
DROP DATABASE IF EXISTS procdb;
DELIMITER $$
CREATE DATABASE procdb;$$
DELIMITER ;


USE procdb;
DROP PROCEDURE IF EXISTS multiply;
DELIMITER $$
CREATE PROCEDURE multiply
(
 IN pFac1 INT, 
 IN pFac2 INT, 
 OUT pProd INT
)
BEGIN
  SET pProd := pFac1 * pFac2;
END;$$
DELIMITER ;

USE procdb;
CALL multiply(5, 5, @Result);
SELECT @Result;


USE procdb;
DROP PROCEDURE IF EXISTS concat;
DELIMITER $$
CREATE PROCEDURE concat
(
 IN pStr1 VARCHAR(20), 
 IN pStr2 VARCHAR(20),
 OUT pConCat VARCHAR(100)
)
BEGIN
  SET pConCat := CONCAT(pStr1, pStr2);
END;$$
DELIMITER ;

USE procdb;
CALL concat('My', 'SQL', @Result);
SELECT @Result;


USE procdb;
DROP PROCEDURE IF EXISTS prepend;
DELIMITER $$
CREATE PROCEDURE prepend
(
 IN inParam VARCHAR(255), 
 INOUT inOutParam INT
)
BEGIN
 DECLARE z INT;
 SET z = inOutParam + 1;
 SET inOutParam = z;
 SELECT inParam;
 SELECT CONCAT('zyxw', inParam);
END;$$
DELIMITER ;

USE procdb;
CALL prepend('abcdefg', @inOutParam);
*/


?>