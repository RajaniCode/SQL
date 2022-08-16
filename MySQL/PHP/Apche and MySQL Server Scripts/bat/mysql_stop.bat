@echo off
cd /D %~dp0
echo Mysql shutdowm ...
C:\xampp\apache\bin\pv -f -k mysqld.exe -q

if not exist mysql\data\mysql.pid GOTO exit
echo Delete mysql.pid ...
del mysql\data\mysql.pid

:exit
