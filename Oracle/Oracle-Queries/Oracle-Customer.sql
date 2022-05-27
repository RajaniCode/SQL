-- Oracle 11 g

-- DROP TABLE Customer;
-- DROP TABLE Customer PURGE;
-- DROP TABLE Customer CASCADE CONSTRAINTS PURGE;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Customer CASCADE CONSTRAINTS PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

-- Note: Double quotes to parse reserved keywords: "Synonym" NVARCHAR2(100),
CREATE TABLE Customer
(
    CustomerID INT NOT NULL,
    FirstName VARCHAR2(100),
    LastName VARCHAR2(100),
    Technology VARCHAR2(100), 
    CONSTRAINT PK_custid PRIMARY KEY(CustomerID)
);

-- DROP SEQUENCE CustomerID_SEQ;
BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE ' || 'CustomerID_SEQ';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -2289 THEN
      RAISE;
    END IF;
END;


CREATE SEQUENCE CustomerID_SEQ;

-- DROP TRIGGER TRG_CustomerID;
BEGIN
  EXECUTE IMMEDIATE 'DROP TRIGGER ' || 'TRG_CustomerID';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -4080 THEN
      RAISE;
    END IF;
END;


CREATE TRIGGER TRG_CustomerID
    BEFORE INSERT ON Customer
    FOR EACH ROW
BEGIN
    SELECT CustomerID_SEQ.NEXTVAL
    INTO :NEW.CustomerID
    FROM DUAL;
END;


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


INSERT INTO Customer (FirstName, LastName, Technology)
SELECT 'Brendan', 'Eich', 'JavaScript' FROM DUAL
UNION ALL 
SELECT 'Guido', 'van Rossum', 'Python' FROM DUAL
UNION ALL 
SELECT 'Yukihiro', 'Matsumoto', 'Ruby' FROM DUAL;


INSERT ALL
  INTO Customer (FirstName, LastName, Technology) VALUES ('Rasmus', 'Lerdorf', 'PHP')
  INTO Customer(FirstName, LastName, Technology) VALUES ('Martin', 'Odersky', 'Scala')
  INTO Customer (FirstName, LastName, Technology) VALUES ('Donald', 'D. Chamberlin', 'SQL')
SELECT * FROM DUAL;