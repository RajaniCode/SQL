from __future__ import print_function

# Note: File name can't be mysql.py
import mysql.connector
from mysql.connector import errorcode

def select():
    try:
        print("Connecting to MySQL database...")
        cnx = mysql.connector.connect(user='root', password='My$ql@Server#5.7',
                                  host='localhost', database='sampledb')

        if cnx.is_connected():
            print("...connection established.")
        else:
            print("...connection failed.")
            
        cursor = cnx.cursor()
        # query = "SELECT * FROM users;"
        query = "SELECT id, username, login_date, login_time, created_at, updated_at FROM users;"
        cursor.execute(query)

        # for record in cursor:
            # print(record)

        rows = cursor.fetchall()
        print('Number of Row(s) =', cursor.rowcount)
        
        for row in rows:
            # print(row)
            counter = 0
            for column in row:
                print(column, end="")
                counter = counter + 1
                if counter < len(row):
                    print(" - ", end="")                
            print("")
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
    select()


'''
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
'''
