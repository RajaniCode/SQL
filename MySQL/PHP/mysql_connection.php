<?php

# PHP CLI
# $ cd "E:\Working\SQL\MySQL\PHP"
# $ php -S 0.0.0.0:8080
# http://localhost:8080/mysql_connection.php
# XAMPP Apache
# http://localhost:86/mysql_connection.php
# C:\xampp\apache\conf\httpd.conf
# Listen 86
# # Virtual hosts
# Include conf/extra/httpd-vhosts.conf
# C:\xampp\apache\conf\extra\httpd-vhosts.conf
/* 
<VirtualHost *:86>
    ServerName mysqlapp.localhost
    DocumentRoot E:/Working/SQL/MySQL/PHP
    SetEnv APPLICATION_ENV "development"
    <Directory E:/Working/SQL/MySQL/PHP>
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
http://localhost:86/phpmyadmin
*/

# MySQL 
$host = 'localhost';
$username = 'root';
// mysql://localhost:3306  ## http://localhost/phpmyadmin
$password = 'My$ql@Server#5.7'; ##
$dbname = 'sampledb'; ## $dbname = 'phpsampledb';

function exception_error_handler($errno, $errstr, $errfile, $errline ) {
    throw new ErrorException($errstr, $errno, 0, $errfile, $errline);
}

set_error_handler("exception_error_handler");

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password); ##
    ## $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username);
    
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    echo "Connected to MySQL Server successfully." . "\n";

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
DROP DATABASE IF EXISTS `sampledb`;
CREATE DATABASE `sampledb`;

USE `sampledb`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL, 
    `login_date` DATE NOT NULL,
    `login_time` TIME NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,    
    CONSTRAINT `pk_id` PRIMARY KEY(`id`),
    CONSTRAINT `idx_username` UNIQUE(`username`)    
);

SELECT * FROM users;

INSERT INTO users(username, login_date, login_time, created_at, updated_at)
VALUES('Foo', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');

SELECT * FROM users;
*/


?>