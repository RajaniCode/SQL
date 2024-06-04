<?php

# PHP CLI
# $ cd "E:\Working\SQL\MySQL\PHP\mysqlapp"
# $ php -S 0.0.0.0:8080
# http://localhost:8080/phpcustomer.php
# XAMPP Apache
# http://localhost:81/phpcustomer.php
# C:\xampp\apache\conf\httpd.conf
# Listen 81
# # Virtual hosts
# Include conf/extra/httpd-vhosts.conf
# C:\xampp\apache\conf\extra\httpd-vhosts.conf
/* 
<VirtualHost *:81>
    ServerName mysqlapp.localhost
    DocumentRoot E:/Working/SQL/MySQL/PHP/mysqlapp
    SetEnv APPLICATION_ENV "development"
    <Directory E:/Working/SQL/MySQL/PHP/mysqlapp>
        DirectoryIndex index.php
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
*/

/*
# Note
services.msc
Start MySQL
Start XAMPP Apache
Start XAMPP MySQL
http://localhost/phpmyadmin
# OR
http://localhost:81/phpmyadmin
*/

# MySQL 
$host = 'localhost';
$username = 'root';
// http://localhost/phpmyadmin  ## // mysql://localhost:3306
## $password = 'My$ql@Server#5.7';
$dbname = 'phpcustomerdb'; ## $dbname = 'customerdb';
function exception_error_handler($errno, $errstr, $errfile, $errline ) {
    throw new ErrorException($errstr, $errno, 0, $errfile, $errline);
}

set_error_handler("exception_error_handler");
try {
    ## $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username); ##
    
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	
    $sql = 'SELECT * FROM Customer;';
 
    $q = $pdo->query($sql);

    $rowcount = $q->rowCount();

    $result = $q->setFetchMode(PDO::FETCH_ASSOC);

    # $result = gettype($result);
    # $dynamic = get_class_methods($pdo);
    # $dynamic = get_class_vars(get_class($pdo));   
    # var_dump($pdo);
    # throw new Exception('Division by zero.');
} catch (PDOException $e) {
    #die("Could not connect to the database $dbname :" . $e->getMessage());
    $error = $e->getMessage();
} catch (Exception $e) {
    $error = $e->getMessage();
} finally {
    $pdo = null;
}

?>
<!DOCTYPE html>
<html>
    <head>
        <title>PHP MySQL Query Data Demo</title>
        <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="jquery-3.1.1.min/jquery-3.1.1.min.js"></script>
        <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>		
    </head>
    <body>
        <?php if(empty($error) && !empty($result) && $rowcount == 0): ?>
            <div class="alert alert-info alert-dismissable" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <?php #print_r($dynamic) ?>
                <?php exit("$result: $rowcount number of rows") ?>				
            </div>
        <?php elseif(empty($error) && !empty($result) && $rowcount > 0): ?>
            <div class="alert alert-success alert-dismissable" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <?php echo "$result: $rowcount number of rows" ?>
            </div>			
        <?php else: ?>
            <div class="alert alert-warning alert-dismissable" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <?php exit("Error: $error") ?>
            </div>
        <?php endif; ?>
        	
        <div id="container">
            <h1>Customer</h1>
            <table class="table table-bordered table-condensed">
                <thead>
                    <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Technology</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = $q->fetch()): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($row['FirstName']) ?></td>
                            <td><?php echo htmlspecialchars($row['LastName']); ?></td>
                            <td><?php echo htmlspecialchars($row['Technology']); ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
    </body>
</html>