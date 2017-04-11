net stop mysql
xcopy D:\mysql-5.6.10-winx64\data\rpms\*.* D:\mysql-5.6.10-winx64-bkp\data\rpms\%date:~0,10%\ /S /I
net start mysql