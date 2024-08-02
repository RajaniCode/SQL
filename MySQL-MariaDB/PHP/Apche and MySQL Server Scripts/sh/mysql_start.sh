echo "Please don't close Window while MySQL is running"

if [[ -f /c/xampp/mysql/bin/mysqld.exe  ]] ; then 											# if mysqld.exe exist
 echo "MySQL is trying to start"
 echo "Please wait  ..."
 echo "MySQL is starting with /c/xampp/mysql/bin/my.ini (console)"
 echo "Use Ctrl-C to stop"
 /c/xampp/mysql/bin/mysqld --defaults-file=/c/xampp/mysql/bin/my.ini --standalone --console # execute mysqld.exe
 if [ $? == 0 ]; then
  echo "$?: MySQL is stopped"
 else
  echo "$?: MySQL could not be started"
 fi  
fi