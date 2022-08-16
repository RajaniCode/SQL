<?php

# PHP CLI
# $ cd "E:\Working\SQL\MySQL\PHP\Select"
# $ php -S 0.0.0.0:8080
# http://localhost:8080/mysql_select.php
# XAMPP Apache
# http://localhost:87/mysql_select.php
# C:\xampp\apache\conf\httpd.conf
# Listen 87
# # Virtual hosts
# Include conf/extra/httpd-vhosts.conf
# C:\xampp\apache\conf\extra\httpd-vhosts.conf
/* 
<VirtualHost *:87>
    ServerName mysqlapp.localhost
    DocumentRoot E:/Working/SQL/MySQL/PHP/Select
    SetEnv APPLICATION_ENV "development"
    <Directory E:/Working/SQL/MySQL/PHP/Select>
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
http://localhost:87/phpmyadmin
*/

# MySQL 
$host = 'localhost';
$username = 'root';
// mysql://localhost:3306  ## http://localhost/phpmyadmin
$password = 'My$ql@Server#5.7'; ##
$dbname = 'classicmodels'; ## $dbname = 'phpclassicmodels';

function exception_error_handler($errno, $errstr, $errfile, $errline ) {
    throw new ErrorException($errstr, $errno, 0, $errfile, $errline);
}

set_error_handler("exception_error_handler");

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password); ##
    ## $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username);
    
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    # customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit
    // $sql = "SELECT * FROM customers ORDER BY customerNumber DESC LIMIT 2;";
    $sql = "SELECT * FROM customers;";
 
    $rows = $pdo->query($sql);
    $rowcount = $rows->rowCount();
 
    foreach($rows as $row) {
        if (php_sapi_name() == 'cli') { // To be verified with Apache
            echo $row['customerNumber'] . " - " . $row['customerName'] . " - " . $row['contactLastName'] . " - " . $row['contactFirstName'] . " - " . $row['phone'] . " - " . $row['addressLine1'] . " - " . $row['addressLine2'] . " - " . $row['city'] . " - " . $row['state'] . " - " . $row['postalCode'] . " - " . $row['country'] . " - " . $row['salesRepEmployeeNumber'] . " - " . $row['creditLimit'] . "\n";
        } else {
            echo "<br/>" . $row['customerNumber'] . " - " . $row['customerName'] . " - " . $row['contactLastName'] . " - " . $row['contactFirstName'] . " - " . $row['phone'] . " - " . $row['addressLine1'] . " - " . $row['addressLine2'] . " - " . $row['city'] . " - " . $row['state'] . " - " . $row['postalCode'] . " - " . $row['country'] . " - " . $row['salesRepEmployeeNumber'] . " - " . $row['creditLimit'] . "<br/>";
        }
    }

    echo "# Note: Query again." . "\n";
    $rows = $pdo->query($sql);
    $result = $rows->setFetchMode(PDO::FETCH_ASSOC);
    
    if ($result === true) {
        while ($row = $rows->fetch(PDO::FETCH_ASSOC)) {
            if (php_sapi_name() == 'cli') { // To be verified with Apache
                echo $row['customerNumber'] . " - " . $row['customerName'] . " - " . $row['contactLastName'] . " - " . $row['contactFirstName'] . " - " . $row['phone'] . " - " . $row['addressLine1'] . " - " . $row['addressLine2'] . " - " . $row['city'] . " - " . $row['state'] . " - " . $row['postalCode'] . " - " . $row['country'] . " - " . $row['salesRepEmployeeNumber'] . " - " . $row['creditLimit'] . "\n";
            } else {
                echo "<br/>" . $row['customerNumber'] . " - " . $row['customerName'] . " - " . $row['contactLastName'] . " - " . $row['contactFirstName'] . " - " . $row['phone'] . " - " . $row['addressLine1'] . " - " . $row['addressLine2'] . " - " . $row['city'] . " - " . $row['state'] . " - " . $row['postalCode'] . " - " . $row['country'] . " - " . $row['salesRepEmployeeNumber'] . " - " . $row['creditLimit'] . "<br/>";
            }
        }
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
}

?>