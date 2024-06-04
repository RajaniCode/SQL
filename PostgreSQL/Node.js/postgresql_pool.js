var Pool = require('pg').Pool;
var pool = new Pool({
  user: 'postgres',
  password: 'P0stgre$ql@Server#9.5',
  host: 'localhost',
  database: 'sampledb',
  max: 10, // max number of clients in pool
  idleTimeoutMillis: 1000, // close & remove clients which have been idle > 1 second
});

pool.on('error', function(e, client) {
  // if a client is idle in the pool
  // and receives an error - for example when your PostgreSQL server restarts
  // the pool will catch the error & let you handle it here
  console.log(e);
});

pool.connect(function(err, client, release) { 
  console.log("Connected to PostgreSQL Server successfully.");
  // const sql = "SELECT * FROM users;"
  const sql = "SELECT id, username, login_date, login_time, created_at, updated_at FROM users;"
  client.query(sql, function(err, result) {
    // you MUST return your client back to the pool when you're done!
    release();
    console.log("Number of Row(s) = " + result.rows.length);
    console.log(result.rows);
  });
});


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