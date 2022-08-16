from __future__ import print_function

import mysql.connector
from mysql.connector import errorcode

def spinout():
    try:
        print("Connecting to MySQL database...")
        cnx = mysql.connector.connect(user='root', password='My$ql@Server#5.7',
                                  host='localhost', database='classicmodels')

        if cnx.is_connected():
            print("...connection established.")
        else:
            print("...connection failed.")
            
        cursor = cnx.cursor()
        args = [103, '@level']
        result_args = cursor.callproc('spinputoutput', args)
        print(result_args)

        for result in result_args:
            print(result)
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
    finally:
        cursor.close()
        cnx.close()
        print("Connection closed.")

if __name__ == "__main__":
    spinout()


'''
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
'''
