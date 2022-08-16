
if [ -f /c/xampp/apache/bin/pv.exe ]; then	# if httpd.exe exist 
 "/c/xampp/apache/bin/pv" -f -k mysqld.exe -q
fi

if [ -f /c/xampp/mysql/data/mysql.pid ]; then
 rm -rf /c/xampp/mysql/data/mysql.pid
fi