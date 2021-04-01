#!/bin/sh
mariadb-install-db -u root

mysqld -u root & sleep 5

mysql -u root -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'tapark'@'%' IDENTIFIED BY '1234' WITH GRANT OPTION;"
mysql -u root -e "FLUSH PRIVILEGES;"

mysql -u root wordpress < wordpress.sql

sleep infinite