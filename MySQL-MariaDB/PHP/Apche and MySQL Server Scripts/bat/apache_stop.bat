@echo off
cd /D %~dp0
C:\xampp\apache\bin\pv -f -k httpd.exe -q
if not exist C:\xampp\apache\logs\httpd.pid GOTO exit
del C:\xampp\apache\logs\httpd.pid

:exit
