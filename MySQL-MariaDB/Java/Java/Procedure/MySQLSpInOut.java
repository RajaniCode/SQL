// java -cp "MySQL-JDBC\mysql-connector-java-8.0.12.jar;.;" MySQLSpInOut
// OR
// export CLASSPATH="MySQL-JDBC\mysql-connector-java-8.0.12.jar;.;"
// echo $CLASSPATH
// OR
// set CLASSPATH=MySQL-JDBC\mysql-connector-java-8.0.12.jar;.;
// echo %CLASSPATH%

// import static java.lang.System.out;

import java.io.InputStream;
import java.io.IOException;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.CallableStatement;
// import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.Properties;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Map.Entry;
import java.lang.StringBuilder;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.sql.Types;

class DataAccessObject {
    // WARN: Establishing SSL connection without server's identity verification is not recommended. 
    // According to MySQL 5.5.45+, 5.6.26+ and 5.7.6+ requirements SSL connection must be established by default if explicit option isn't set. 
    // For compliance with existing applications not using SSL the verifyServerCertificate property is set to 'false'. 
    // You need either to explicitly disable SSL by setting useSSL=false, or set useSSL=true and provide truststore for server certificate verification. 
    // useSSL=false
    // private final String url = "jdbc:mysql://localhost:3306/urlspdb?user=root&password=My$ql@Server#8.0.12&useSSL=false";
    // private final String url = "jdbc:mysql://localhost:3306/urlspdb?useSSL=false";
    // private final String user = "root";
    // private final String password = "My$ql@Server#8.0.12"; 
    
    public Connection getConnection() throws SQLException {
        Connection conn = null;
        try  {
             InputStream input = new FileInputStream("config.properties");
             Properties connectionProps = new Properties();
             connectionProps.load(input);
             String url = connectionProps.getProperty("url"); //      
             String user = connectionProps.getProperty("user"); //
             String password = connectionProps.getProperty("password"); //
             // conn = DriverManager.getConnection(url); //
             conn = DriverManager.getConnection(url, user, password); //              
        } catch (IOException e) {
             e.printStackTrace();
        }
        return conn;
    }

    public void testConnection() {
        try (Connection conn = getConnection();) {
            System.out.println("Connected to MySQL Server successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } 
}

class MySQLProcedure
{
    public <T> CallableStatement setParams(CallableStatement statement, Map<Integer, T> params) throws SQLException {
        for(Entry<Integer, T> paramsEntry : params.entrySet()) {        	
            int key = paramsEntry.getKey();
            statement.setObject(key, paramsEntry.getValue());
        }
        return statement;
    }

    public <T> Map<Integer, Object> getOutParams(String query, Map<Integer, T> params, int[] resultRowNumbers) {
        Map<Integer, Object> outParams = new HashMap<Integer, Object>();
        DataAccessObject dao = new DataAccessObject();
        try (Connection conn = dao.getConnection();) {
            CallableStatement statement = conn.prepareCall(query);
            System.out.println("Connected to MySQL Server successfully.");
            statement = setParams(statement, params);
            // int result = statement.executeUpdate();
            boolean hadResults = statement.execute();
            for(int i = 0; i < resultRowNumbers.length; i++) {
                outParams.put(i, statement.getObject(resultRowNumbers[i]));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return outParams;
    }
}

public class MySQLSpInOut { 
    public static void main(String args[]) {                
        MySQLProcedure mysqlProc = new MySQLProcedure();
        StringBuilder query = new StringBuilder();
        query.append("{ CALL spinout(?, ?) }");
        Map<Integer, Object> params = new HashMap<Integer, Object>(); 
        params.put(1, 4);
        params.put(2, "@out_count");
        int[] resultRowNumbers = new int[] {2};
        Map<Integer, Object> outParams = mysqlProc.getOutParams(query.toString(), params, resultRowNumbers);
        if(outParams != null) {
            for(Entry<Integer, Object> outParamsEntry : outParams.entrySet()) {        	
                System.out.println(outParamsEntry.getValue());
            }
        }        
    }
}


/*
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
/*
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
*/