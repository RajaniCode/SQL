const Client = require('pg').Client;

const client = new Client({
  user: 'postgres',
  password: 'P0stgre$ql@Server#9.5',
  database: 'sampledb',
  host: 'localhost',
  port: 5432
});

client.on('drain', client.end.bind(client)); //disconnect client when all queries are finished
client.connect();

// const sql = "SELECT * FROM users;"
const sql = "SELECT id, username, login_date, login_time, created_at, updated_at FROM users;"

const query = client.query(sql, function(err, result) {
  console.log("Connected to PostgreSQL Server successfully.");
  // console.log(result);
  // console.log(result.rows.length);
  console.log("Number of Row(s) = " + result.rows.length);
  for (var index in result.rows) {
    // console.log(result.rows[index]);
    // console.log(JSON.stringify(result.rows[index]));
    var stringified = JSON.stringify(result.rows[index]);
    var parsed = JSON.parse(stringified);
    console.log(parsed.id + " - " + parsed.username + " - " + parsed.login_date + " - " + 
                parsed.login_time + " - " + parsed.created_at + " - " + parsed.updated_at);
  }
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