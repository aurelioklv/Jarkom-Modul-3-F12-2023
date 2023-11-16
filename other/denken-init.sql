CREATE USER 'kelompokf12'@'%' IDENTIFIED BY 'qwe123';
CREATE USER 'kelompokf12'@'localhost' IDENTIFIED BY 'qwe123';
CREATE DATABASE kelompokf12;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokf12'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokf12'@'localhost';
FLUSH PRIVILEGES;