# !/bin/sh

# Not setup
if [ ! -f ".cnf_success" ]; then

	mkdir -p /run/mysqld /var/lib/mysql
	mariadb-install-db --datadir=/var/lib/mysql
	chown -R mysql:mysql /var/lib/mysql /run/mysqld

	# Run mysqld_safe as background to set up config
	/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

	# Make query.sql
	cat << EOF > query.sql
	GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
	GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
	SET PASSWORD FOR 'root'@'localhost'=PASSWORD('$MYSQL_ROOT_PASSWORD') ;
	DROP DATABASE IF EXISTS test ;
	FLUSH PRIVILEGES ;
	CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
	GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
	FLUSH PRIVILEGES ;
EOF

	# Wait 10 sec until mysqld_safe server is on
	for i in {1..10}
	do
		if ! mysqladmin ping; then
			sleep 1
		else
			break
		fi
	done
	
	if ! mysqladmin ping; then
		printf "Failed to run mysqld"
		exit 1
	fi

	# Set up mysql with query.sql
	mariadb < query.sql
	rm -f query.sql

	# Kill background mysqld_safe
	ps | grep "/usr/bin/mysqld_safe" | grep -v "grep" | awk '{print $1}' | xargs kill -9

	# Setup flag
	touch .cnf_success
fi

# Run mysqld_safe
/usr/bin/mysqld_safe --datadir=/var/lib/mysql --skip-networking=0 --bind-address=0.0.0.0
