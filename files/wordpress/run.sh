# !/bin/sh

for i in $(seq 30)
do
	if ! mysqladmin -u $MYSQL_USER -p$MYSQL_USER_PASSWORD -h $MYSQL_HOST ping 2> /dev/null; then
		printf "Wait for mariadb server... ($i sec)\n"
		sleep 1
	else
		break
	fi
done

wp core download --locale=ko_KR --allow-root

wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_USER_PASSWORD --dbhost=$MYSQL_HOST --allow-root

wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root

wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=author --allow-root

php-fpm7 -F
