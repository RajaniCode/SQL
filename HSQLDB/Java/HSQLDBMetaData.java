// java -cp "E:\Working\SQL\HSQLDB\Java\HSQLDB-JDBC\hsqldb.jar;.;" HSQLDBMetaData
// OR
// export CLASSPATH="E:\Working\SQL\HSQLDB\Java\HSQLDB-JDBC\hsqldb.jar;.;"
// echo $CLASSPATH
// OR
// set CLASSPATH=E:\Working\SQL\HSQLDB\Java\HSQLDB-JDBC\hsqldb.jar;.;
// echo %CLASSPATH%

// import static java.lang.System.out;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;

public class HSQLDBMetaData {
  public static void main(String[] args) throws Exception {
    Connection conn = getConnection();

    DatabaseMetaData mtdt = conn.getMetaData();
    System.out.println("URL in use: " + mtdt.getURL());
    System.out.println("User name: " + mtdt.getUserName());
    System.out.println("DBMS name: " + mtdt.getDatabaseProductName());
    System.out.println("DBMS version: " + mtdt.getDatabaseProductVersion());
    System.out.println("Driver name: " + mtdt.getDriverName());
    System.out.println("Driver version: " + mtdt.getDriverVersion());
    System.out.println("supp. SQL Keywords: " + mtdt.getSQLKeywords());

    conn.close();
  }

  private static Connection getConnection() throws Exception {
    Class.forName("org.hsqldb.jdbcDriver");
    String url = "jdbc:hsqldb:hsql://localhost/sampledb";

    return DriverManager.getConnection(url, "SA", "");
  }
}