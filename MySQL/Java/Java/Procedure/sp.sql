# PROCEDURE 1
USE spdb;

DROP PROCEDURE IF EXISTS sp;
DELIMITER $$
CREATE PROCEDURE sp
(
 IN cust_id INT,
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
  rental
 WHERE
  customer_id = cust_id
 AND 
  status = 'Shipped';
 
 -- canceled
 SELECT
  count(*) INTO canceled
 FROM
  rental
 WHERE
  customer_id = cust_id
 AND 
  status = 'Canceled';
 
 -- resolved
 SELECT
  count(*) INTO resolved
 FROM
  rental
 WHERE
  customer_id = cust_id
 AND 
  status = 'Resolved';
 
 -- disputed
 SELECT
  count(*) INTO disputed
 FROM
  rental
 WHERE
  customer_id = cust_id
 AND 
  status = 'Disputed';
END;$$
DELIMITER ; 

USE spdb;
CALL sp(6, @shipped, @canceled, @resolved, @disputed);
SELECT @shipped, @canceled, @resolved, @disputed;


# PROCEDURE 2
USE spdb;
DROP PROCEDURE IF EXISTS spin;
DELIMITER $$
CREATE PROCEDURE spin
(
 IN n INT
) 
BEGIN
 # SELECT * FROM customer LIMIT n;
 SELECT `customer_id`, `customer_name`, `email`, `date_of_birth`, `income`, `credit_limit`, `create_date`, `last_update` FROM customer LIMIT n;
END;$$
DELIMITER ;

USE spdb;
CALL spin(6);


# PROCEDURE 3
USE spdb;
DROP PROCEDURE IF EXISTS spinout;
DELIMITER $$
CREATE PROCEDURE spinout 
(
 IN in_customer_id INT, OUT out_count INT
) 
BEGIN
 SELECT COUNT(*) INTO out_count  FROM customer WHERE customer_id > in_customer_id;
END; $$
DELIMITER ;

USE spdb;
CALL spinout(4, @out_count);
SELECT @out_count;


# PROCEDURE 4
USE spdb;
DROP PROCEDURE IF EXISTS spinputoutput;
DELIMITER $$
CREATE PROCEDURE spinputoutput
(
 in  p_customer_id int(11), 
 inout p_customerLevel  varchar(10) # Note # out p_customerLevel  varchar(10)
)
BEGIN
 DECLARE creditlimit double; 
 SELECT 
  credit_limit INTO creditlimit
 FROM 
  customer
 WHERE 
  customer_id = p_customer_id; 
 IF creditlimit > 50 THEN
  SET p_customerLevel = 'PLATINUM';
 ELSEIF (creditlimit <= 50 AND creditlimit >= 10) THEN
  SET p_customerLevel = 'GOLD';
 ELSEIF creditlimit < 10 THEN
  SET p_customerLevel = 'SILVER';
 END IF; 
END; $$
DELIMITER ;

USE spdb;
CALL spinputoutput(3, @level);
SELECT @level AS level;


# DROP DATABASE IF EXISTS spdb;
# DELIMITER $$
# CREATE DATABASE spdb;$$
# DELIMITER ;


# PROCEDURE 5
USE spdb;
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

USE spdb;
CALL multiply(5, 5, @Result);
SELECT @Result;


# PROCEDURE 6
USE spdb;
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

USE spdb;
CALL concat('My', 'SQL', @Result);
SELECT @Result;


# PROCEDURE 7
USE spdb;
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

USE spdb;
CALL prepend('abcdefg', @inOutParam);