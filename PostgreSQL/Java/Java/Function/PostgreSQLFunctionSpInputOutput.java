// java -cp "PostgreSQL-JDBC\postgresql-42.2.5.jar;.;" PostgreSQLFunctionSpInputOutput
// OR
// export CLASSPATH="PostgreSQL-JDBC\postgresql-42.2.5.jar;.;"
// echo $CLASSPATH
// OR
// set CLASSPATH=PostgreSQL-JDBC\postgresql-42.2.5.jar;.;
// echo %CLASSPATH%

// import static java.lang.System.out;

import java.io.InputStream;
import java.io.IOException;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
// import java.sql.CallableStatement;
import java.sql.PreparedStatement;
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
    // private final String url = "jdbc:postgresql://localhost/spdb?user=postgres&password=PostgreSQL-10.5-1";
    // private final String url = "jdbc:postgresql://localhost:5432/spdb";
    // private final String user = "postgres";
    // private final String password = "PostgreSQL-10.5-1";
    
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
            System.out.println("Connected to PostgreSQL Server successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }     
}

class PostgreSQLFunction
{
    public <T> PreparedStatement setParams(PreparedStatement prepStatement, Map<Integer, T> params) throws SQLException {
        for(Entry<Integer, T> paramsEntry : params.entrySet()) {        	
            int key = paramsEntry.getKey();
            // System.out.println("key:" + key);
            // System.out.println("value:" + paramsEntry.getValue());
            prepStatement.setObject(key, paramsEntry.getValue());
        }
        return prepStatement;
    }

    public <T> Map<Integer, Object> getOutParams(String query, Map<Integer, T> params, int[] resultRowNumbers) {
        Map<Integer, Object> outParams = new HashMap<Integer, Object>();
        ResultSet rs;

        DataAccessObject dao = new DataAccessObject();             
        // dao.testConnection();

        try (Connection conn = dao.getConnection();) {
            PreparedStatement prepstatement = conn.prepareStatement(query);
            System.out.println("Connected to PostgreSQL Server successfully.");

            prepstatement = setParams(prepstatement, params);    
            rs = prepstatement.executeQuery();
            while (rs.next()) {
                for(int i = 0; i < resultRowNumbers.length; i++) {
                    outParams.put(i, rs.getObject(resultRowNumbers[i]));  
                }
            }                 
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return outParams;
    }
}

public class PostgreSQLFunctionSpInputOutput { 
    public static void main(String args[]) {                
        PostgreSQLFunction postgreFunction = new PostgreSQLFunction(); 
        StringBuilder query = new StringBuilder();
        query.append("SELECT * FROM spinputoutput(?, ?);");
        Map<Integer, Object> params = new HashMap<Integer, Object>(); 
        params.put(1, 3);
        params.put(2, "");
        int[] resultRowNumbers = new int[] { 1 };       
        Map<Integer, Object> outParams = postgreFunction.getOutParams(query.toString(), params, resultRowNumbers);
        if(outParams != null) {
            for(Entry<Integer, Object> outParamsEntry : outParams.entrySet()) {        	
                System.out.println(outParamsEntry.getValue());
            }
        }        
    }
}


/*
-- FUNCTION 1

-- \connect spdb;

DROP FUNCTION sp;

CREATE OR REPLACE FUNCTION sp
(
 cust_id INT,
 OUT shipped INT,
 OUT canceled INT,
 OUT resolved INT,
 OUT disputed INT
)
AS $$
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
END; $$
LANGUAGE plpgsql;

-- SELECT sp(6);
SELECT * FROM sp(6);

-- FUNCTION 2

-- \connect spdb;

DROP FUNCTION spin;

CREATE OR REPLACE FUNCTION spin(n int)
    RETURNS TABLE (
        customer_id int,
        customer_name varchar,
        email varchar,
        date_of_birth date,
        income double precision,
        credit_limit decimal,
        create_date date,
        last_update timestamp
 )
AS $$
BEGIN
    RETURN QUERY SELECT * FROM customer LIMIT n;
END; $$
LANGUAGE 'plpgsql';

-- SELECT spin(6);
SELECT * FROM spin(6);

-- NOTE

DROP FUNCTION spin;

CREATE OR REPLACE FUNCTION spin(int) RETURNS setof RECORD AS
'
DECLARE
r RECORD;
BEGIN
    FOR r in EXECUTE ''SELECT customer_id, customer_name, email, date_of_birth, income, credit_limit, create_date, last_update FROM customer LIMIT '' || $1 loop
        RETURN NEXT r;
    END LOOP;
RETURN;
END
'
LANGUAGE 'plpgsql';

SELECT * FROM spin(6) as cust(customer_id int, customer_name varchar, email varchar, date_of_birth date, income double precision, credit_limit decimal, create_date date, last_update timestamp);


-- FUNCTION 3

-- \connect spdb;

DROP FUNCTION spinout;

CREATE OR REPLACE FUNCTION spinout(in_customer_id int, OUT out_count bigint)
AS $$
BEGIN
 -- out_count := (SELECT COUNT(*) FROM customer WHERE customer_id > in_customer_id);
 SELECT COUNT(*) INTO out_count  FROM customer WHERE customer_id > in_customer_id;
END; $$
LANGUAGE plpgsql;

-- SELECT spinout(6);
SELECT * FROM spinout(6);

-- NOTE

CREATE OR REPLACE FUNCTION spinout(in_customer_id int) RETURNS bigint AS $$
    SELECT COUNT(*) FROM customer WHERE customer_id > in_customer_id;
$$ LANGUAGE SQL;

SELECT spinout(6);


-- FUNCTION 4

-- \connect spdb;

DROP FUNCTION spinputoutput;

CREATE OR REPLACE FUNCTION spinputoutput
(
 p_customer_id int, 
 inout p_customerLevel  varchar -- Note -- out p_customerLevel  varchar
)
AS $$
DECLARE creditlimit decimal; 
BEGIN 
 SELECT 
  credit_limit INTO creditlimit
 FROM 
  customer
 WHERE 
  customer_id = p_customer_id; 
 IF creditlimit > 50 THEN
  p_customerLevel := 'PLATINUM';
 ELSIF (creditlimit <= 50 AND creditlimit >= 10) THEN
  p_customerLevel := 'GOLD';
 ELSIF creditlimit < 10 THEN
  p_customerLevel := 'SILVER';
 END IF; 
END; $$
LANGUAGE plpgsql;

-- SELECT spinputoutput(3, '');
SELECT * FROM spinputoutput(3, '');


-- FUNCTION 5

-- \connect spdb;

DROP FUNCTION multiply;

CREATE OR REPLACE FUNCTION multiply
(
 pFac1 INT, 
 pFac2 INT, 
 OUT pProd INT
)
AS $$
BEGIN
  pProd := pFac1 * pFac2;
END; $$
LANGUAGE plpgsql;

-- SELECT multiply(5, 5);
SELECT * FROM multiply(5, 5);

-- NOTE

CREATE OR REPLACE FUNCTION square(
 INOUT a NUMERIC)
AS $$
BEGIN
 a := a * a;
END; $$
LANGUAGE plpgsql;

SELECT square(4);


-- FUNCTION 6

-- \connect spdb;

DROP FUNCTION concat;

CREATE OR REPLACE FUNCTION concat
(
 pStr1 VARCHAR, 
 pStr2 VARCHAR,
 OUT pConCat VARCHAR
)
AS $$
BEGIN
  pConCat := CONCAT(pStr1, pStr2);
END; $$
LANGUAGE plpgsql;

--SELECT * FROM concat('My', 'SQL');
SELECT concat('My', 'SQL');


-- FUNCTION 7

-- \connect spdb;

DROP FUNCTION prepend;

CREATE OR REPLACE FUNCTION prepend(inparam text)
RETURNS SETOF text AS $$
BEGIN
  RETURN NEXT inparam;
  RETURN NEXT 'zyxw' || inparam;
END;
$$ LANGUAGE plpgsql;

-- SELECT prepend('abcdefg');
SELECT * FROM prepend('abcdefg');
*/