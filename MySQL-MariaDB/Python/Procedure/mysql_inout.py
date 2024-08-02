from __future__ import print_function

import mysql.connector
from mysql.connector import errorcode

def inout():
    try:
        print("Connecting to MySQL database...")
        cnx = mysql.connector.connect(user='root', password='My$ql@Server#5.7',
                                  host='localhost', database='procdb')

        if cnx.is_connected():
            print("...connection established.")
        else:
            print("...connection failed.")
            
        cursor = cnx.cursor()
        args = ['abcdefg', 1]
        cursor.callproc('prepend', args)
        
        for resultset in cursor.stored_results():
            for result in resultset.fetchall():
                print(result[0])               
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
    inout()


'''
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
'''
