var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'My$ql@Server#5.7',
  database : 'classicmodels',
});

// var post  = {id: 1, title: 'Hello MySQL'};
var post  = ""

connection.connect(function(err) {
  // connected! (unless `err` is set)
  console.log("...connection established.")
  // var sql = "SELECT * FROM customers ORDER BY customerNumber DESC LIMIT 2;"
  var sql = "SELECT * FROM customers;"
  var query = connection.query(sql, post, function(err, results) {
    //console.log(results);
    console.log(results.length);
    var numCallbacks = 0;
    for (var index in results){
      // console.log(results[index]);
      // console.log(JSON.stringify(results[index]));
      var stringified = JSON.stringify(results[index]);
      var parsed = JSON.parse(stringified);
      console.log(parsed.customerNumber + " - " + parsed.customerName + " - " + parsed.contactLastName + " - " + parsed.contactFirstName + " - " + 
                  parsed.phone + " - " + parsed.addressLine1 + " - " + parsed.addressLine2 + " - " + parsed.city + " - " + parsed.state + " - " + 
                  parsed.postalCode + " - " + parsed.country + " - " + parsed.salesRepEmployeeNumber + " - " + parsed.creditLimit);
      if (++numCallbacks == results.length) {
        console.log("Connection end.")
        return connection.end();
      }
    }    
  });
  //console.log(query.sql);
});
