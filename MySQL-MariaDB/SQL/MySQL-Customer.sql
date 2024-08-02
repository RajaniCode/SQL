#MySQL

#SELECT DATABASE() FROM DUAL;
#SELECT DATABASE();

DROP DATABASE IF EXISTS `customerdb`;
CREATE DATABASE `customerdb`;
USE `customerdb`;

DROP TABLE IF EXISTS `Customer`;
CREATE TABLE `Customer`
(
    `CustomerId` INT NOT NULL AUTO_INCREMENT,
    `FirstName` NVARCHAR(100),
    `LastName` NVARCHAR(100),
    `Technology` NVARCHAR(100),
    CONSTRAINT PK_custid PRIMARY KEY(`CustomerId`)
);

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Bill', 'Gates', 'Microsoft');

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Larry', 'Page', 'Google');


INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Steve', 'Jobs', 'Apple');


INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Anders', 'Hejlsberg', 'C#');


INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Bjarne', 'Stroustrup', 'C++');


INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('James', 'Gosling', 'Java');


INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Scott', 'Guthrie', 'ASP.NET');


INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Don', 'Syme', 'F#');


INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Dennis', 'Ritchie', 'C');


INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Hasso', 'Plattner', 'SAP');


SELECT * FROM Customer;


INSERT INTO Customer(FirstName, LastName, Technology)
SELECT 'Brendan', 'Eich', 'JavaScript'
UNION ALL
SELECT 'Guido', 'van Rossum', 'Python'
UNION ALL
SELECT 'Yukihiro', 'Matsumoto', 'Ruby';


SELECT * FROM Customer;


INSERT INTO Customer (FirstName, LastName, Technology)
VALUES
('Rasmus', 'Lerdorf', 'PHP'),
('Martin', 'Odersky', 'Scala'),
('Donald', 'D. Chamberlin', 'SQL');

SELECT * FROM Customer;

#Note
/*
USE customerdb;

Truncate Customer;

#OR
SET SQL_SAFE_UPDATES=0;
DELETE FROM Customer;



#AUTO_INCREMENT

DROP DATABASE IF EXISTS `customerdb`;
CREATE DATABASE `customerdb`;

USE `customerdb`;

DROP TABLE IF EXISTS `Customer`;
CREATE TABLE `Customer`
(
    `CustomerId` INT NOT NULL AUTO_INCREMENT,
    `FirstName` NVARCHAR(100),
    `LastName` NVARCHAR(100),
    `Technology` NVARCHAR(100),
    CONSTRAINT PK_custid PRIMARY KEY(`CustomerId`)
);

# ALTER TABLE `Customer` AUTO_INCREMENT = 2;
# CustomerId = 0 # SESSION variable will make sure that the SQL_MODE in not changed globally
# SET SESSION SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
# Revert
# SET SESSION SQL_MODE = '';
[
# To change the SQL_MODE globally
# SET GLOBAL SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
# SET GLOBAL SQL_MODE = '';
]

# auto_increment_increment controls the interval between successive column values
# Default = 1
# SET @@auto_increment_increment = 1;
# auto_increment_offset determines the starting point for the AUTO_INCREMENT column value
# Default = 1
#SET @@auto_increment_offset = 1;
# SHOW VARIABLES LIKE 'auto_inc%';

INSERT INTO Customer(CustomerId, FirstName, LastName, Technology)
VALUES(0, 'Bill', 'Gates', 'Microsoft');

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Larry', 'Page', 'Google');

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Steve', 'Jobs', 'Apple');

SELECT * FROM Customer;
*/