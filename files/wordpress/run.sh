# !/bin/sh

for i in $(seq 30)
do
	if ! mysqladmin -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST ping 2> /dev/null; then
		sleep 1
	else
		break
	fi
done

wp --allow-root --path=/var/www/wordpress config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST

/bin/sh
