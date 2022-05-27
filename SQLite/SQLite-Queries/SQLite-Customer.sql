--SQLite


DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer
(
    CustomerId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    FirstName TEXT,
    LastName TEXT,
    Technology TEXT
);
SELECT * FROM Customer;

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

