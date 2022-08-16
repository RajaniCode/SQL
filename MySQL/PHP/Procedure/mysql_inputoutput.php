<?php

# PHP CLI
# $ cd "E:\Working\SQL\MySQL\PHP\Procedure"
# $ php -S 0.0.0.0:8080
# http://localhost:8080/mysql_inout.php
# XAMPP Apache
# http://localhost:88/mysql_inout.php
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
$dbname = 'classicmodels'; ## $dbname = 'phpclassicmodels';
$options = array(
    PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
);

function exception_error_handler($errno, $errstr, $errfile, $errline ) {
    throw new ErrorException($errstr, $errno, 0, $errfile, $errline);
}

set_error_handler("exception_error_handler");

try {
    echo "Connecting to MySQL database..." . "\n";
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password, $options); ##
    ## $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username);
    
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    echo "Connected to MySQL Server successfully." . "\n";
    
    $stmt = $pdo->prepare("CALL spinputoutput(103, @level);");
    $stmt->execute();
    $stmt->closeCursor();
    $rowList = $pdo->query("SELECT @level AS level")->fetch(PDO::FETCH_ASSOC);
    foreach($rowList as $row) {
      echo $row . "\n";
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
USE classicmodels;
DROP PROCEDURE IF EXISTS sp;
DELIMITER $$
CREATE PROCEDURE sp
(
 IN cust_no INT,
 OUT shipped INT,
 OUT canceled INT,
 OUT resolved INT,
 OUT disputed INT
)
BEGIN
 -- shipped
 SELECT
  count(*) INTO shipped
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Shipped';
 
 -- canceled
 SELECT
  count(*) INTO canceled
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Canceled';
 
 -- resolved
 SELECT
  count(*) INTO resolved
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Resolved';
 
 -- disputed
 SELECT
  count(*) INTO disputed
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Disputed';
END;$$
DELIMITER ; 

USE classicmodels;
CALL sp(141, @shipped, @canceled, @resolved, @disputed);
SELECT @shipped, @canceled, @resolved, @disputed;


USE classicmodels;
DROP PROCEDURE IF EXISTS spin;
DELIMITER $$
CREATE PROCEDURE spin
(
 IN n INT
) 
BEGIN
 # SELECT * FROM customers LIMIT n;
 SELECT customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit FROM customers LIMIT n;
END;$$
DELIMITER ;

USE classicmodels;
CALL spin(2);


USE classicmodels;
DROP PROCEDURE IF EXISTS spinout;
DELIMITER $$
CREATE PROCEDURE spinout 
(
 IN in_customerNumber INT, OUT out_count INT
) 
BEGIN
 SELECT COUNT(*) INTO out_count  FROM customers WHERE customerNumber > in_customerNumber;
END; $$
DELIMITER ;

USE classicmodels;
CALL spinout(200, @out_count);
SELECT @out_count;


USE classicmodels;
DROP PROCEDURE IF EXISTS spinputoutput;
DELIMITER $$
CREATE PROCEDURE spinputoutput
(
 in  p_customerNumber int(11), 
 inout p_customerLevel  varchar(10) # Note # out p_customerLevel  varchar(10)
)
BEGIN
 DECLARE creditlim double; 
 SELECT 
  creditlimit INTO creditlim
 FROM 
  customers
 WHERE 
  customerNumber = p_customerNumber; 
 IF creditlim > 50000 THEN
  SET p_customerLevel = 'PLATINUM';
 ELSEIF (creditlim <= 50000 AND creditlim >= 10000) THEN
  SET p_customerLevel = 'GOLD';
 ELSEIF creditlim < 10000 THEN
  SET p_customerLevel = 'SILVER';
 END IF; 
END; $$
DELIMITER ;

USE classicmodels;
CALL spinputoutput(103, @level);
SELECT @level AS level;
*/


?>