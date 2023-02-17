# !/bin/sh

# If not setup
if [ ! -f ".cnf_success" ]; then

	echo "Configure Mariadb."
	mkdir -p /run/mysqld /var/lib/mysql
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql
	chown -R mysql:mysql /var/lib/mysql /run/mysqld

	# Run mysqld_safe as background to set up config
	/usr/bin/mysqld_safe --user=mysql --datadir=/var/lib/mysql &

	# Make query.sql
	cat << EOF > query.sql
	GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
	GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
	SET PASSWORD FOR 'root'@'localhost'=PASSWORD('$MYSQL_ROOT_PASSWORD') ;
	DROP DATABASE IF EXISTS test ;
	FLUSH PRIVILEGES ;
	CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
	GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
	FLUSH PRIVILEGES ;
EOF

	# Wait until mysqld_safe server is on
	if ! mysqladmin -w=30 ping; then
		printf "Failed to run mysqld"
		exit 1
	fi

	# Set up mysql with query.sql
	mariadb < query.sql
	rm -f query.sql

	# Kill background mysqld_safe
	ps | grep "/usr/bin/mariadb" | grep -v "grep" | awk '{print $1}' | xargs kill -15

	# Setup flag
	touch .cnf_success
else
	echo "Already Setup."
fi

# Run mysqld_safe
/usr/bin/mysqld_safe --user=mysql --datadir=/var/lib/mysql --skip-networking=0 --bind-address=0.0.0.0
