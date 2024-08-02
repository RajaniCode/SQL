use feature ':5.22';
use strict;
use warnings;
# Git CMD # > ppm install DBD-mysql
use DBI;

=pod
sub stringify_undef_for {
    for my $x ( @_ ) {
        if (! defined $$x) {
            $$x = "undef";            
        }
    }
}
=cut

# MySQL
my $dsn = "DBI:mysql:classicmodels";
my $username = "root";
my $password = 'My$ql@Server#5.7';

my $dbh = DBI->connect($dsn, $username, $password);

die "failed to connect to MySQL database:DBI->errstr()" unless($dbh);

say "Connected to MySQL Server successfully."; 

# my $sth = $dbh->prepare("SELECT * FROM customers ORDER BY customerNumber DESC LIMIT 2;") or die "prepare statement failed: $dbh->errstr()";

my $sth = $dbh->prepare("SELECT * FROM customers;") or die "prepare statement failed: $dbh->errstr()";
 
$sth->execute() or die "execution failed: $dbh->errstr()"; 
 
$sth->dump_results();

=pod
# my ($customerNumber, $customerName, $contactLastName, $contactFirstName, $phone, $addressLine1, $addressLine2, $city, $state, $postalCode, $country, $salesRepEmployeeNumber, $creditLimit);
 
while(my ($customerNumber, $customerName, $contactLastName, $contactFirstName, $phone, $addressLine1, $addressLine2, $city, $state, $postalCode, $country, $salesRepEmployeeNumber, $creditLimit) = $sth->fetchrow()) {
    # no warnings 'uninitialized';
    stringify_undef_for(\$customerNumber, \$customerName, \$contactLastName, \$contactFirstName, \$phone, \$addressLine1, \$addressLine2, \$city, \$state, \$postalCode, \$country, \$salesRepEmployeeNumber, \$creditLimit);
    say("$customerNumber - $customerName - $contactLastName - $contactFirstName - $phone - $addressLine1 - $addressLine2 - $city - $state - $postalCode - $country - $salesRepEmployeeNumber - $creditLimit");                   
    # say($customerNumber . " - " . $customerName . " - " . $contactLastName . " - " . $contactFirstName . " - " . $phone . " - " . $addressLine1 . " - " . $addressLine2 . " - " . $city . " - " . $state . " - " . $postalCode . " - " . $country . " - " . $salesRepEmployeeNumber . " - " . $creditLimit);                   
}
=cut

$sth->finish();

$dbh->disconnect();