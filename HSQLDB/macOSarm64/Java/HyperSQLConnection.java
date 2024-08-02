/*
# HyperSQL Server
% cd $HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/Java
[
% mkdir -p hsqldb
]
% cd hsqldb
% java --version
% java -cp "$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/Java/hsqldb-2.7.3/hsqldb.jar" org.hsqldb.Server -database.0 file:xdb -dbname.0 sampledb


# config.properties
url = jdbc:hsqldb:hsql://localhost/sampledb
user = SA
password =


# Java
# Terminal New Window
% cd $HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/Java
// java -cp "hsqldb-2.7.3/hsqldb.jar" HyperSQLConnection.java
// OR
// export CLASSPATH="$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/hsqldb-2.7.3/hsqldb.jar"
// java HyperSQLConnection.java
*/


import java.io.InputStream;
import java.io.IOException;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
// import java.sql.Statement;
// import java.sql.ResultSet;
// import java.sql.ResultSetMetaData;
import java.util.Properties;
// import java.util.List;
// import java.util.ArrayList;
// import java.util.Map;
// import java.util.HashMap;
// import java.util.Map.Entry;
// import java.lang.StringBuilder;


class HyperSQLConnection { 
    public static void main(String args[]) {  
	var propertiesSystem = new SystemProperties();
        propertiesSystem.print();
              
        DataAccessObject dao = new DataAccessObject();             
        dao.testConnection();        
    }
}

class DataAccessObject {
    // private final String url = "jdbc:hsqldb:hsql://localhost/sampledb";
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
            System.out.println("Connected to HSQLDB successfully."); 
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } 
}

class SystemProperties {
    public void print() {
        System.out.println(String.format("OS Name: %s", System.getProperty("os.name")));
        System.out.println(String.format("OS Version: %s", System.getProperty("os.version")));
        System.out.println(String.format("OS Architecture: %s", System.getProperty("os.arch")));
        System.out.println(String.format("Java Version: %s", System.getProperty("java.version")));
        // System.getProperties().list(System.out);
        System.out.println();
    }
}
