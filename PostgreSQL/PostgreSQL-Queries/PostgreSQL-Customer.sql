--PostgreSQL

--psql -U postgres
--postgres=# \connect postgres;
--postgres=# DROP DATABASE customerdb;

CREATE DATABASE customerdb;

DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer
(
    CustomerId SERIAL NOT NULL,
    FirstName VARCHAR(100), 
    LastName VARCHAR(100),
    Technology VARCHAR(100),
    CONSTRAINT PK_custid PRIMARY KEY(CustomerId)
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