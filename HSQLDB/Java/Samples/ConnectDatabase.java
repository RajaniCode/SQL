// java -cp "E:\Working\SQL\HSQLDB\Java\Samples\HSQLDB-JDBC\hsqldb.jar;.;" ConnectDatabase
// OR
// export CLASSPATH="E:\Working\SQL\HSQLDB\Java\Samples\HSQLDB-JDBC\hsqldb.jar;.;"
// echo $CLASSPATH
// OR
// set CLASSPATH=E:\Working\SQL\HSQLDB\Java\Samples\HSQLDB-JDBC\hsqldb.jar;.;
// echo %CLASSPATH%

// import static java.lang.System.out;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectDatabase {
   public static void main(String[] args) {
      Connection con = null;
      
      try {
         //Registering the HSQLDB JDBC driver
         Class.forName("org.hsqldb.jdbc.JDBCDriver");
         //Creating the connection with HSQLDB
         con = DriverManager.getConnection("jdbc:hsqldb:hsql://localhost/testdb", "SA", "");
         if (con!= null){
            System.out.println("Connection created successfully");
            
         }else{
            System.out.println("Problem with creating connection");
         }
      
      }  catch (Exception e) {
         e.printStackTrace(System.out);
      }
   }
}