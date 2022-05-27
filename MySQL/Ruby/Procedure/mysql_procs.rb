require 'mysql2'

begin
 puts "Connecting to MySQL database..."
 client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "My$ql@Server#5.7", :database => "procdb") 
 if client.ping
  puts "...connection established."
 else
  puts "...connection failed."
 end
 client.query("CALL multiply(5, 5, @Result);") 
 results = client.query("SELECT @Result;")
 if !results.nil?
  puts results.count
  results.each do |row|
   puts row
  end
 end
 client.query("CALL concat('My', 'SQL', @Result);") 
 results = client.query("SELECT @Result;") 
 if !results.nil?
  puts results.count
  results.each do |row|
   puts row
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
=end