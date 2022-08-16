Oracle Universal Connection Pool (UCP) 12.1.0.2 Readme
=========================================================
Base Readme (12.1.0.1) @ http://download.oracle.com/otn/utilities_drivers/jdbc/121010/ucp_Readme.txt

Fixes in 12.1.0.2
------------------
17164359    UCP not wrapping underlying exception
16300278    UCP gives significantly lower throughput vs ICC
16805157    InstanceAlreadyExistsException still occurs with the fix of bug 13090371
16597762    UniversalConnectionPoolManager doesn't register UniversalConnectionPoolMBean 
15928641    NULL connection from UCP when PoolXADataSource is used with connection labelling 
16298836    Threads hang when UCP connection borrowing validation enabled 
14794935    UCP leak connection from PoolDataSourceImpl 
18134568    Logon storms during connection drain with UCP during planned outages 