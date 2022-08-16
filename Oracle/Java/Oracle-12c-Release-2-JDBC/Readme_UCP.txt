Oracle Universal Connection Pool
Release 12.2.0.1.0

Production README
=======================================================================


Contents Of This Release
------------------------

For all platforms:

  [ORACLE_HOME]/ucp/lib contains:

  - ucp.jar
    Classes for use with JDK 8. It contains the Universal Connection Pool
    classes, as well as the built-in JDBC Pool Adapter classes for
    standalone UCP / JDBC applications.

  - ucpdemos.jar
    Classes for use with JDK 8. It contains the Universal Connection Pool
    demos and code samples, sample logging configurations, and a
    quick-start toolkit for Fast Connection Failover.

  Javadoc / Documentation / Demo:

    All of the above are also available for download on OTN.


Installation
------------

The Oracle Installer puts the Universal Connection Pool files in the
[ORACLE_HOME]/ucp directory.


Setting Up Your Environment
---------------------------

On Windows platforms:
  - Add [ORACLE_HOME]\ucp\lib\ucp.jar to your CLASSPATH.

On all Unix platforms:
  - Add [ORACLE_HOME]/ucp/lib/ucp.jar to your CLASSPATH.


Important Notes
---------------

 * Support for Database Sharding:
   Starting from Oracle Database 12c Release 2 (12.2.0.1), Universal
   Connection Pool (UCP) supports database sharding. UCP recognizes the
   sharding keys specified and connects to the specific shard. Sharding
   uses Global Data Services (GDS), where GDS routes a client request to
   an appropriate database, based on various parameters such as availability,
   load, network latency, and replication lag.

 * Shared Pool Support for Multitenant Data Sources:
   Starting from Oracle Database 12c Release 2 (12.2.0.1), multitenant
   data sources can share a common pool of connections in UCP and repurpose
   connections in the common connection pool, whenever needed.

 * Enhanced FCF support:
   Starting from Oracle Database 12c Release 2 (12.2.0.1), UCP automatically
   enables FCF/FAN processing whenever possible. FAN processing is optimized
   to avoid unnecessary event-parsing, and adds support for server
   -drain_timeout option in HA events.

 * XML configuration:
   Starting from Oracle Database 12c Release 2 (12.2.0.1), UCP supports
   XML configuration. Users can specify both UCP-enabled JDBC data sources
   and pool instances in XML. The XML schema file is in ucp.jar.

 * Security - proxy authentication:
   In this release, UCP supports both the single-session and double-session
   models for proxy authentication.

 * DRCP Enhancements:
   In this release, UCP adds multi-tagging support for Database Resident
   Connection Pooling (DRCP).

 * Compatibility:
   UCP works with older Oracle databases such as 11g and 10g databases,
   as well as non-Oracle databases such as DB2, SQLServer. Please refer
   to OTN for complete UCP certification information, including JDBC driver
   and vendor database versions.

 * UCP's connection affinity features (Web-session based affinity and
   Transaction based affinity) are designed to work with Oracle Real
   Application Clusters (RAC) 11.1 or above, since they are designed to
   leverage features of the 11g RAC database. These UCP features may not
   work as expected with older RAC versions.

 * If you are using UCP's Connection Labeling feature, and enabled Fast
   Connection Failover as well as RAC Load Balancing Advisory, note that
   UCP's Runtime Connection Load-Balancing (RCLB) takes precedence over
   connection labeling. In other words, in a RAC enabled environment,
   UCP's RCLB would provide better performance characteristics than
   generic Connection Labeling feature.


Known Problems/Limitations In This Release
------------------------------------------

 * Bug #25478801: UCP performance regression against 12.1.0.2.0. Customers
   can apply UCP one-off patch #25676218.

 * Bug #25219185: failure to obtain connection after JBoss reload. Customers
   can apply UCP one-off patch #25409963.

 * Bug #25559137: package oracle/jdbc/logging causing seal-violation issue
   between JDBC and UCP. Customers can apply UCP one-off patch #25592508.

 * For applications using the built-in pool adapter PoolDataSource and
   PoolXADataSource, the pool allows dynamic setting of properties on
   the specified connection factory, such as connect-URL, host, port,
   etc., during run-time. However, other than connect-URL, the pool
   does not refresh itself when setting other connection factory properties.
   This applies to both standard connection factory properties (for
   example, those on javax.sql.DataSource including user, password,
   portNumber, databaseName, etc.), and customized properties specific
   to a connection factory.

   Workaround: Application should try to avoid dynamic setting of
     important connection factory properties, after the pool has been
     populated with connections. If this can not be avoided, application
     can explicitly perform pool refresh after all dynamic property set.


Key Problems/Limitations Fixed in This Release
----------------------------------------------

BUG-23190035:
    UCP doesn't support alias URL for RAC cluster

BUG-21856509:
    UCP closes/commits borrowed connection when enforcing max pool size

BUG-21666072:
    UCP connections not drained after DataGuard switchover 

BUG-21328052:
    UCP FCF planned-down draining does not cleanup available connections
    right away when using replay driver

BUG-20697812:
    FCF UP event processing works incorrectly when RLB is disabled

BUG-20682812:
    IO exception when trying to serialize a PoolDataSource object

BUG-20534233:
    Pool refresh does not work properly for borrowed connections

BUG-18905788:
    Subscriber creation should be specific to each ONS object

