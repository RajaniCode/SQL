/*
# H2 Server
% java --version
% cd $HOME/Desktop/GitHub/SQL-1/H2/macOSarm64
[
% mkdir -p h2 
]
% java -cp "$HOME/Desktop/GitHub/SQL-1/H2/h2-2.2.224/h2-2.2.224.jar" org.h2.tools.Console -baseDir $HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/h2 -properties $HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/h2
[
# Pre-created
% java -cp "$HOME/Desktop/GitHub/SQL-1/H2/h2-2.2.224/h2-2.2.224.jar" org.h2.tools.Server -baseDir $HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/h2 -properties $HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/h2
]


# config.properties
url = jdbc:h2:tcp://localhost/sampledb
user = SA
password =


# Terminal New Window
% java --version
% cd /Users/rajaniapple/Desktop/GitHub/SQL-1/H2/macOSarm64/Java
% java -cp "$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/Java/h2-2.2.224/h2-2.2.224.jar" H2Connection.java
# OR
% export CLASSPATH="$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/Java/h2-2.2.224/h2-2.2.224.jar"
% java H2Connection.java
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

class H2Connection { 
    public static void main(String args[]) {      
	var propertiesSystem = new SystemProperties();
        propertiesSystem.print();
          
        DataAccessObject dao = new DataAccessObject();             
        dao.testConnection();        
    }
}

class DataAccessObject {
    // private final String url = "jdbc:h2:tcp://localhost/sampledb";
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