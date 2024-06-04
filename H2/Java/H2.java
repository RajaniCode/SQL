// java -cp "E:\Working\SQL\H2\Java\H2-Maven-Jar\h2-1.4.193.jar;.;" H2
// OR
// export CLASSPATH="E:\Working\SQL\H2\Java\H2-Maven-Jar\h2-1.4.193.jar;.;"
// echo $CLASSPATH
// OR
// set CLASSPATH=E:\Working\SQL\H2\Java\H2-Maven-Jar\h2-1.4.193.jar;.;
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
    // private final String url = "jdbc:h2:tcp://192.168.56.1:9092/sampledb";
    // private final String user = "SA";
    // private final String password = ""; 
    
    private Connection getConnection() throws SQLException {
        Connection conn = null;
        try  {
             InputStream input = new FileInputStream("config.properties");
             Properties connectionProps = new Properties();
             connectionProps.load(input);
             String url = connectionProps.getProperty("url"); //        
             String user = connectionProps.getProperty("user"); //
             String password = connectionProps.getProperty("password"); //
             conn = DriverManager.getConnection(url, user, password); //              
        } catch (IOException e) {
             e.printStackTrace();
        }
        return conn;
    }

    public void testConnection() {
        try (Connection conn = getConnection();) {
            System.out.println("Connected to H2 successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } 

    public Map<Integer, Map<String, String>> getData(String query) {
        Map<Integer, Map<String, String>> rows = new HashMap<Integer, Map<String, String>>();
        ResultSet rs;
        try (Connection conn = getConnection();
            Statement stmt = conn.createStatement()) {
            System.out.println("Connected to H2 successfully."); 
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

class H2 { 
    public static void main(String args[]) {                
        DataAccessObject dao = new DataAccessObject();             
        // dao.testConnection();
        StringBuilder selectQuery = new StringBuilder();
        // selectQuery.append("Select * FROM users;");
        selectQuery.append("SELECT id, username, login_date, login_time, created_at, updated_at FROM users;");
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
# Git Bash # cd
$ java -cp h2-1.4.193.jar org.h2.tools.Server -baseDir /e/Working/SQL/H2/Java/H2-Base -properties /e/Working/SQL/H2/Java/H2-Base
# http://192.168.56.1:8082/login.jsp?jsessionid=3ff8a8e81be0a077dc7a73cea0f9dd30
# JDBC URL: jdbc:h2:sampledb
# Test Connection
# Save

# Git Bash # cd
$ java -cp h2-1.4.193.jar org.h2.tools.Shell -url "jdbc:h2:tcp://192.168.56.1:9092/sampledb" -user "sa"

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    --id INT IDENTITY NOT NULL,
    id INT  GENERATED BY DEFAULT AS IDENTITY (START WITH 101, INCREMENT BY 1),
    username VARCHAR(50) NOT NULL, 
    login_date DATE DEFAULT CURRENT_DATE,
    login_time TIME DEFAULT CURRENT_TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT idx_username UNIQUE(username)    
);
COMMIT;

SELECT * FROM users;

INSERT INTO users(username, login_date, login_time, created_at, updated_at)
VALUES('Foo', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');
COMMIT;

SELECT * FROM users;
*/