<?php

# Enable PDO_PGSQL driver 
# C:\xampp\php\php.ini # Uncomment # ;extension=php_pdo_pgsql.dll
# extension=php_pdo_pgsql.dll

# PHP CLI
# $ cd "E:\Working\SQL\MySQL\PHP"
# $ php -S 0.0.0.0:8080
# http://localhost:8080/postgresql.php
# XAMPP Apache
# http://localhost:86/postgresql.php
# C:\xampp\apache\conf\httpd.conf
# Listen 87
# # Virtual hosts
# Include conf/extra/httpd-vhosts.conf
# C:\xampp\apache\conf\extra\httpd-vhosts.conf
/* 
<VirtualHost *:87>
    ServerName mysqlapp.localhost
    DocumentRoot E:\Working\SQL\PostgreSQL\PHP
    SetEnv APPLICATION_ENV "development"
    <Directory E:\Working\SQL\PostgreSQL\PHP>
        DirectoryIndex index.php
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
*/

/*
# Note
services.msc
Start XAMPP Apache
http://localhost/phpmyadmin
# OR
http://localhost:86/phpmyadmin
*/


# PostgreSQL 
$host = 'localhost';
$port = 5432;
$username = 'postgres';
$password = 'P0stgre$ql@Server#9.5';
$dbname = 'sampledb';

function exception_error_handler($errno, $errstr, $errfile, $errline ) {
    throw new ErrorException($errstr, $errno, 0, $errfile, $errline);
}

set_error_handler("exception_error_handler");

try {
    $pdo = new PDO("pgsql:host=$host;port=$port;dbname=$dbname", $username, $password);
    
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Connected to PostgreSQL Server successfully." . "\n";
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

DROP DATABASE IF EXISTS sampledb;

CREATE DATABASE sampledb;

-- \connect sampledb;

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    id SERIAL NOT NULL,
    username VARCHAR(50) NOT NULL, 
    login_date DATE NOT NULL DEFAULT CURRENT_DATE,
    login_time TIME NOT NULL DEFAULT CURRENT_TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT idx_username UNIQUE(username)    
);

SELECT * FROM users;

INSERT INTO users(username, login_date, login_time, created_at, updated_at)
VALUES('Foo', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');

SELECT * FROM users;

*/

?>