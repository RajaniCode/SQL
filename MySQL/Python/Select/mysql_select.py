from __future__ import print_function

import mysql.connector
from mysql.connector import errorcode

def select():
    try:
        print("Connecting to MySQL database...")
        cnx = mysql.connector.connect(user='root', password='My$ql@Server#5.7',
                                  host='localhost', database='classicmodels')

        if cnx.is_connected():
            print("...connection established.")
        else:
            print("...connection failed.")
            
        cursor = cnx.cursor()
        # query = "SELECT * FROM customers ORDER BY customerNumber DESC LIMIT 2;"
        query = "SELECT * FROM customers;"
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
