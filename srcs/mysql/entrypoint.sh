#!/bin/sh
mysql_install_db --user=root

echo "CREATE DATABASE IF NOT EXISTS wordpress;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'tapark'@'%' IDENTIFIED BY '1234' WITH GRANT OPTION;
FLUSH PRIVILEGES;" > creat_usr_wpdb.sql

mysqld -u root --bootstrap < creat_usr_wpdb.sql

mysqld -u root