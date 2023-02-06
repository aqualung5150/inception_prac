#!/bin/sh

mkdir -p /run/mysqld /var/lib/mysql && \
chown -R mysql:mysql /run/mysqld /var/lib/mysql

mysql_install_db --user=mysql --ldata=/var/lib/mysql

/usr/bin/mysqld_safe --user=mysql --skip-networking=0 --verbose=0
