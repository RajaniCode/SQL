require 'mysql2'

begin
 puts "Connecting to MySQL database..."
 client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "My$ql@Server#5.7", :database => "classicmodels") 
 if client.ping
  puts "...connection established."
 else
  puts "...connection failed."
 end
 client.query("CALL sp(141, @shipped, @canceled, @resolved, @disputed);")
 result_args = client.query("SELECT @shipped, @canceled, @resolved, @disputed;")
 if !result_args.nil?
  puts result_args.count
  result_args.each do |args|
   puts args
  end
 end 
rescue Mysql2::Error => e
 puts e.errno
 puts e.error
ensure
 if !client.nil?
  client.close 
  puts "Connection closed."
 end
end


=begin
USE classicmodels;
DROP PROCEDURE IF EXISTS sp;
DELIMITER $$
CREATE PROCEDURE sp
(
 IN cust_no INT,
 OUT shipped INT,
 OUT canceled INT,
 OUT resolved INT,
 OUT disputed INT
)
BEGIN
 -- shipped
 SELECT
  count(*) INTO shipped
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Shipped';
 
 -- canceled
 SELECT
  count(*) INTO canceled
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Canceled';
 
 -- resolved
 SELECT
  count(*) INTO resolved
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Resolved';
 
 -- disputed
 SELECT
  count(*) INTO disputed
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Disputed';
END;$$
DELIMITER ; 

USE classicmodels;
CALL sp(141, @shipped, @canceled, @resolved, @disputed);
SELECT @shipped, @canceled, @resolved, @disputed;


USE classicmodels;
DROP PROCEDURE IF EXISTS spin;
DELIMITER $$
CREATE PROCEDURE spin
(
 IN n INT
) 
BEGIN
 # SELECT * FROM customers LIMIT n;
 SELECT customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit FROM customers LIMIT n;
END;$$
DELIMITER ;

USE classicmodels;
CALL spin(2);


USE classicmodels;
DROP PROCEDURE IF EXISTS spinout;
DELIMITER $$
CREATE PROCEDURE spinout 
(
 IN in_customerNumber INT, OUT out_count INT
) 
BEGIN
 SELECT COUNT(*) INTO out_count  FROM customers WHERE customerNumber > in_customerNumber;
END; $$
DELIMITER ;

USE classicmodels;
CALL spinout(200, @out_count);
SELECT @out_count;


USE classicmodels;
DROP PROCEDURE IF EXISTS spinputoutput;
DELIMITER $$
CREATE PROCEDURE spinputoutput
(
 in  p_customerNumber int(11), 
 inout p_customerLevel  varchar(10) # Note # out p_customerLevel  varchar(10)
)
BEGIN
 DECLARE creditlim double; 
 SELECT 
  creditlimit INTO creditlim
 FROM 
  customers
 WHERE 
  customerNumber = p_customerNumber; 
 IF creditlim > 50000 THEN
  SET p_customerLevel = 'PLATINUM';
 ELSEIF (creditlim <= 50000 AND creditlim >= 10000) THEN
  SET p_customerLevel = 'GOLD';
 ELSEIF creditlim < 10000 THEN
  SET p_customerLevel = 'SILVER';
 END IF; 
END; $$
DELIMITER ;

USE classicmodels;
CALL spinputoutput(103, @level);
SELECT @level AS level;
=end