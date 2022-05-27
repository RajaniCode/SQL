echo "Please close this command only for Shutdown"

if [ -f /c/xampp/apache/bin/httpd.exe ]; then	# if httpd.exe exist 
  echo "Apache 2 is starting ..."
  echo "Use Ctrl-C to stop"
  /c/xampp/apache/bin/httpd.exe					# execute httpd.exe		
  if [ $? == 0 ]; then
   echo "$?: Apache is stopped"
  else
   echo "$?: Apache could not be started"
  fi  
fi
