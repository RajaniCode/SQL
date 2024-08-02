
if [ -f /c/xampp/apache/bin/pv.exe ]; then	# if httpd.exe exist 
 "/c/xampp/apache/bin/pv" -f -k httpd.exe -q
fi

if [ -f /c/xampp/apache/logs/httpd.pid ]; then
 rm -rf /c/xampp/apache/logs/httpd.pid
fi


