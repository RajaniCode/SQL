// java -cp "E:\Working\SQL\HSQLDB\Java\Samples\HSQLDB-JDBC\hsqldb.jar;.;" InsertQuery
// OR
// export CLASSPATH="E:\Working\SQL\HSQLDB\Java\Samples\HSQLDB-JDBC\hsqldb.jar;.;"
// echo $CLASSPATH
// OR
// set CLASSPATH=E:\Working\SQL\HSQLDB\Java\Samples\HSQLDB-JDBC\hsqldb.jar;.;
// echo %CLASSPATH%

// import static java.lang.System.out;

import java.sql.Connection; 
import java.sql.DriverManager; 
import java.sql.Statement;  

public class InsertQuery {
   public static void main(String[] args) { 
      Connection con = null; 
      Statement stmt = null; 
      int result = 0; 
      try { 
         Class.forName("org.hsqldb.jdbc.JDBCDriver"); 
         con = DriverManager.getConnection( "jdbc:hsqldb:hsql://localhost/testdb", "SA", ""); 
         stmt = con.createStatement(); 
         result = stmt.executeUpdate("INSERT INTO test_tbl VALUES (100,'Java The Complete Reference, Eighth Edition', 'Herbert Schildt', NOW())"); 
         con.commit(); 
      }catch (Exception e) { 
         e.printStackTrace(System.out); 
      } 
      System.out.println(result+" rows effected"); 
      System.out.println("Rows inserted successfully"); 
   } 
}