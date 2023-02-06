#!/bin/sh

mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

mysql_install_db --user=mysql --datadir=/var/lib/mysql

touch query.sql
cat << EOF > query.sql
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}');
DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
FLUSH PRIVILEGES;
EOF

/usr/bin/mysqld_safe --user=mysql --datadir=/var/lib/mysql

mariadb < query.sql
