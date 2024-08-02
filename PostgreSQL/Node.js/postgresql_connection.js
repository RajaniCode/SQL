const Client = require('pg').Client;

const client = new Client({
  user: 'postgres',
  password: 'P0stgre$ql@Server#9.5',
  database: 'sampledb',
  //database: 'customerdb',
  host: 'localhost',
  port: 5432
});

client.connect();

const sql = "SELECT current_database();"

const query = client.query(sql);

query.on('row', (row) => {
  // console.log(row['current_database']);
  console.log("Connected to PostgreSQL Server successfully.");
});

query.on('end', () => { client.end(); });


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