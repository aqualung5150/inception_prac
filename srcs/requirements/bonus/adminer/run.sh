# !/bin/sh

if cat /etc/php8/php-fpm.d/www.conf | grep -q "user = nobody"; then
	echo "Php-fpm Not yet setup, Configure www.conf."
	sed -i "s/.*user = nobody.*/user = nginx/g" /etc/php8/php-fpm.d/www.conf
	sed -i "s/.*group = nobody.*/group = nginx/g" /etc/php8/php-fpm.d/www.conf
	sed -i "s/.*listen = 127.0.0.1.*/listen = 8000/g" /etc/php8/php-fpm.d/www.conf
else
	echo "Php-fpm already setup." 
fi

echo "Php-fpm Started..." && \
php-fpm8 -F