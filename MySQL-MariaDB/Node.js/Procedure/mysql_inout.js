var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'My$ql@Server#5.7',
  database : 'procdb',
});

// var post  = {id: 1, title: 'Hello MySQL'};
var post  = "";

connection.connect(function(err) {
  // connected! (unless `err` is set)
  console.log("...connection established.")
  var query = connection.query("CALL prepend('abcdefg', @inOutParam);", post, function(err, results) {
    //console.log(results);
    //console.log(results.length);
    var numCallbacks = 0;   
    for (var index in results){
      //if (results[index].constructor.name != "Array") {
      if (results[index].constructor.name != "OkPacket") {
        //console.log(results[index]); 
        console.log(JSON.stringify(results[index]));
      }
      if (++numCallbacks == results.length) {
        console.log("Connection end.")
        return connection.end();
      }
    }
  });
  //console.log(query.sql);
});


/*
DROP DATABASE IF EXISTS procdb;
DELIMITER $$
CREATE DATABASE procdb;$$
DELIMITER ;


USE procdb;
DROP PROCEDURE IF EXISTS multiply;
DELIMITER $$
CREATE PROCEDURE multiply
(
 IN pFac1 INT, 
 IN pFac2 INT, 
 OUT pProd INT
)
BEGIN
  SET pProd := pFac1 * pFac2;
END;$$
DELIMITER ;

USE procdb;
CALL multiply(5, 5, @Result);
SELECT @Result;


USE procdb;
DROP PROCEDURE IF EXISTS concat;
DELIMITER $$
CREATE PROCEDURE concat
(
 IN pStr1 VARCHAR(20), 
 IN pStr2 VARCHAR(20),
 OUT pConCat VARCHAR(100)
)
BEGIN
  SET pConCat := CONCAT(pStr1, pStr2);
END;$$
DELIMITER ;

USE procdb;
CALL concat('My', 'SQL', @Result);
SELECT @Result;


USE procdb;
DROP PROCEDURE IF EXISTS prepend;
DELIMITER $$
CREATE PROCEDURE prepend
(
 IN inParam VARCHAR(255), 
 INOUT inOutParam INT
)
BEGIN
 DECLARE z INT;
 SET z = inOutParam + 1;
 SET inOutParam = z;
 SELECT inParam;
 SELECT CONCAT('zyxw', inParam);
END;$$
DELIMITER ;

USE procdb;
CALL prepend('abcdefg', @inOutParam);
*/