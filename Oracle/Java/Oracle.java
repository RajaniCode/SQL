// java -cp "E:\Working\SQL\Oracle\Java\Oracle-12c-Release-2-JDBC\ojdbc8.jar;.;" Oracle
// OR
// export CLASSPATH="E:\Working\SQL\Oracle\Java\Oracle-12c-Release-1-JDBC\ojdbc7.jar;.;"
// echo $CLASSPATH
// OR
// set CLASSPATH=E:\Working\SQL\Oracle\Java\Oracle-12c-Release-1-JDBC\ojdbc7.jar;.;
// echo %CLASSPATH%

// import static java.lang.System.out;

import java.io.InputStream;
import java.io.IOException;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.Properties;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Map.Entry;
import java.lang.StringBuilder;

class DataAccessObject {    
    // Oracle 11g
    // private final String url = "jdbc:oracle:thin:SYSTEM/Oracl11ge@localhost:1521:xe";
    // private final String url = "jdbc:oracle:thin:@localhost:1521:xe";
    // Oracle 12c
    // private final String url = "jdbc:oracle:oci8:SYSTEM/Oracle12cSE2@";
    private final String url = "jdbc:oracle:oci8:@";
    private final String user = "SYSTEM";
    private final String password = "Oracle12cSE2"; 
    
    private Connection getConnection() throws SQLException {
        Connection conn = null;
        try  {
             InputStream input = new FileInputStream("config.properties");
             Properties connectionProps = new Properties();
             connectionProps.load(input);
             // String url = connectionProps.getProperty("url"); //        
             // String user = connectionProps.getProperty("user"); //
             // String password = connectionProps.getProperty("password"); //
             // conn = DriverManager.getConnection(url); //
             conn = DriverManager.getConnection(url, user, password); //              
        } catch (IOException e) {
             e.printStackTrace();
        }
        return conn;
    }

    public void testConnection() {
        try (Connection conn = getConnection();) {
            System.out.println("Connected to Oracle Server successfully."); 
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } 

    public Map<Integer, Map<String, String>> getData(String query) {
        Map<Integer, Map<String, String>> rows = new HashMap<Integer, Map<String, String>>();
        ResultSet rs;
        try (Connection conn = getConnection();
            Statement stmt = conn.createStatement()) {
            System.out.println("Connected to Oracle Server successfully."); 
            rs = stmt.executeQuery(query);
            int rowCount = 0;
            ResultSetMetaData meta = rs.getMetaData();
            while(rs.next()) {
                int columnCount = meta.getColumnCount();
                Map<String, String> columns = new HashMap<String, String>();
                for (int i = 1; i <= columnCount; i++) {
                    String type = meta.getColumnClassName(i);
                    String key = meta.getColumnName(i);                    
                    String value = rs.getString(key);
                    columns.put(key, value);
                }
                /*
                for(Entry<String, String> columnsEntry : columns.entrySet()) {        	
        	    System.out.println(columnsEntry.getKey() + ": " + columnsEntry.getValue());
                }
                System.out.println("Number of Columns(s) = " + columns.size());
                */
                rowCount++;
                rows.put(rowCount, columns);
            }
            /*
            for(Entry<Integer, Map<String, String>> rowsEntry : rows.entrySet()) {        	
                for(Entry<String, String> columnsEntry : rowsEntry.getValue().entrySet()) {        	
        	    System.out.println(columnsEntry.getKey() + ": " + columnsEntry.getValue());
                }
            }
            System.out.println("Number of Row(s) = " + rows.size());
            */
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rows;
    } 
}

class Oracle { 
    public static void main(String args[]) {                
        DataAccessObject dao = new DataAccessObject();             
        // dao.testConnection();
        StringBuilder selectQuery = new StringBuilder();
        // selectQuery.append("Select * FROM users"); // Note // No semicolon in query
        selectQuery.append("SELECT id, username, login_date, login_time, created_at, updated_at FROM users"); // Note // No semicolon in query
        Map<Integer, Map<String, String>> rows = dao.getData(selectQuery.toString());
        if (rows != null) {
            int rowCount = rows.size();
            System.out.println("Number of Row(s) = " + rowCount);
            if (rowCount > 0) {           
                for(Entry<Integer, Map<String, String>> rowsEntry : rows.entrySet()) {                	
                    // int columnsCount = 0;                                
                    for(Entry<String, String> columnsEntry : rowsEntry.getValue().entrySet()) {                	
                        System.out.println(columnsEntry.getKey() + ": " + columnsEntry.getValue());
                        /*
                        columnsCount++;
                        System.out.print(columnsEntry.getValue());
                        if (columnsCount < rowsEntry.getValue().entrySet().size()) {
                            System.out.print(" - " );
                        }
                        */
                    }
                    System.out.println();
                }
            }
        }
    }
}


/*
$ sqlplus SYSTEM/Oracle12cSE2
$ sqlplus SYSTEM/Oracle12cSE2@orcl
$ sqlplus SYSTEM/Oracle12cSE2@localhost:1521/orcl

DROP SEQUENCE seq_id;

CREATE SEQUENCE seq_id
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

DROP TABLE users;

CREATE TABLE users
(
    id INT NOT NULL,
    username VARCHAR(50) NOT NULL, 
    login_date DATE NOT NULL,
    login_time VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT idx_username UNIQUE(username)    
);

COMMIT;

INSERT INTO users(id, username, login_date, login_time, created_at, updated_at)
VALUES
(
seq_id.nextval,
'Foo', 
TO_DATE('2016-11-06', 'YYYY-MM-DD'), 
TO_CHAR(TO_DATE('2016-11-06 10:49:35', 'YYYY-MM-DD HH:MI:SS'),'HH24:MI:SS'), 
TO_TIMESTAMP('2016-11-06 10:49:35.0', 'YYYY-MM-DD HH:MI:SS.FF'), 
TO_TIMESTAMP('2016-11-06 10:49:35.0', 'YYYY-MM-DD HH:MI:SS.FF')
);

COMMIT;

SELECT * FROM users;
*/