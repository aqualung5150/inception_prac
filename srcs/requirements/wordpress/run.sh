# !/bin/sh

# php-fpm config
# php-fpm.config includes www.config file
# Edits 'user', 'owner' and 'group' in www.config file.
if cat /etc/php7/php-fpm.d/www.conf | grep -q "user = nobody"; then
	echo "Php-fpm Not yet setup, Configure www.conf."
	sed -i "s/.*user = nobody.*/user = nginx/g" /etc/php7/php-fpm.d/www.conf
	sed -i "s/.*group = nobody.*/group = nginx/g" /etc/php7/php-fpm.d/www.conf
	sed -i "s/.*listen = 127.0.0.1.*/listen = 9000/g" /etc/php7/php-fpm.d/www.conf
	echo "env[MYSQL_HOST] = \$MYSQL_HOST" >> /etc/php7/php-fpm.d/www.conf
  	echo "env[MYSQL_USER] = \$MYSQL_USER" >> /etc/php7/php-fpm.d/www.conf
  	echo "env[MYSQL_USER_PASSWORD] = \$MYSQL_USER_PASSWORD" >> /etc/php7/php-fpm.d/www.conf
  	echo "env[MYSQL_DATABASE] = \$MAMYSQL_DATABASE" >> /etc/php7/php-fpm.d/www.conf
else
	echo "Php-fpm already setup." 
fi

# wp-config
if [ ! -f "/var/www/html/wordpress/wp-config.php" ]; then
	echo "Wordpress Not yet setup, Configure wp-config.php."
	for i in $(seq 60)
	do
		if ! mysqladmin -u $MYSQL_USER -p$MYSQL_USER_PASSWORD -h $MYSQL_HOST ping 2> /dev/null; then
			printf "Wait for mariadb server... ($i sec)\n"
			sleep 1
		else
			break
		fi
	done

	# Creates wp-config.php.
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_USER_PASSWORD --dbhost=$MYSQL_HOST --allow-root --path=/var/www/html/wordpress && \
	echo "define ( 'WP_REDIS_HOST', '$WP_REDIS_HOST' );" >> /var/www/html/wordpress/wp-config.php && \
	echo "define ( 'WP_REDIS_PORT', $WP_REDIS_PORT );" >> /var/www/html/wordpress/wp-config.php && \
	echo "define ( 'WP_REDIS_DATABASE', $WP_REDIS_DATABASE );" >> /var/www/html/wordpress/wp-config.php && \
	echo "define ( 'WP_REDIS_TIMEOUT', $WP_REDIS_TIMEOUT );" >> /var/www/html/wordpress/wp-config.php && \
	echo "define ( 'WP_REDIS_READ_TIMEOUT', $WP_REDIS_READ_TIMEOUT );" >> /var/www/html/wordpress/wp-config.php && \
	echo "define ( 'WP_CACHE', true );" >> /var/www/html/wordpress/wp-config.php
	# Creates the WordPress tables in the database.
	wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root --path=/var/www/html/wordpress
	# Creates a new user.
	wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=author --allow-root --path=/var/www/html/wordpress
	# Install and run redis. => https://objectcache.pro/docs/wp-cli
	wp plugin install redis-cache --activate --allow-root --path=/var/www/html/wordpress
	wp redis enable --allow-root --path=/var/www/html/wordpress
	# wp redis status --allow-root --path=/var/www/html/wordpress
else
	echo "Wordpress already setup."
fi

# Runs php-fpm foreground.
echo "Php-fpm7 Started..." && \
php-fpm7 -F
