const Client = require('pg').Client;

const client = new Client({
  user: 'postgres',
  password: 'P0stgre$ql@Server#9.5',
  database: 'sampledb', //
  // database: 'customerdb',
  host: 'localhost',
  port: 5432
});

client.connect(console.log("Connected to PostgreSQL Server successfully."));

const sql_count = "SELECT count(*) FROM users;"; //
// const sql_count = "SELECT count(*) FROM customer;";

const query_count = client.query(sql_count);

query_count.on('row', (row) => { 
  console.log("Number of Row(s) = " + row['count']);
});

const sql_select = "SELECT id, username, login_date, login_time, created_at, updated_at FROM users;" // const sql = "SELECT * FROM users;" //
// const sql_select = "SELECT CustomerId, FirstName, LastName, Technology FROM customer;" // const sql = "SELECT * FROM customer;" 

const query_select = client.query(sql_select);

query_select.on('row', (row) => {
  //console.log(row);
  //console.log(Object.keys(row).length);
  //console.log(Object.getOwnPropertyNames(row));
  for (var column in row) {
    console.log(column + ": " + row[column]);
  }
  console.log("\n");
});

query_select.on('end', () => {  client.end(); });


/*
query.on('row', (row) => {
  //console.log(row);
  var numberOfKeys = Object.keys(row).length;
  //console.log(numberOfKeys);
  //console.log(Object.getOwnPropertyNames(row));
  var columnCount = 0;
  for (var column in row) {
    //columnCount++;
    process.stdout.write(row[column] + "");
    if (++columnCount < numberOfKeys) {
      process.stdout.write(" - "); 
    }  
  }
  console.log("\n");
});

query.on('end', () => { client.end(); });
*/


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


/*
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
*/