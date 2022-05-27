var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'My$ql@Server#5.7',
  database : 'sampledb',
});

// var post  = {id: 1, title: 'Hello MySQL'};
var post  = ""

connection.connect(function(err) {
  // connected! (unless `err` is set)
  console.log("...connection established.")
  // var sql = "SELECT * FROM users;"
  var sql = "SELECT id, username, login_date, login_time, created_at, updated_at FROM users;"
  var query = connection.query(sql, post, function(err, results) {
    //console.log(results);
    //console.log(results.length);
    console.log("Number of Row(s) = " + results.length);
    var numCallbacks = 0;
    for (var index in results){
      // console.log(results[index]);
      // console.log(JSON.stringify(results[index]));
      var stringified = JSON.stringify(results[index]);
      var parsed = JSON.parse(stringified);
      console.log(parsed.id + " - " + parsed.username + " - " + parsed.login_date + " - " + 
                  parsed.login_time + " - " + parsed.created_at + " - " + parsed.updated_at);
      if (++numCallbacks == results.length) {
        console.log("Connection end.")
        return connection.end();
      }
    }    
  });
  //console.log(query.sql);
});


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