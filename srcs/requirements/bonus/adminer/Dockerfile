FROM alpine:3.15

# Install required php packages and wp-cli
RUN apk update && \
	apk add --no-cache dumb-init curl \
	php7 php7-phar php7-fpm php7-common php7-session php7-iconv php7-json \
	php7-gd php7-curl php7-xml php7-mysqli php7-imap \
	php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap \
	php7-xmlrpc php7-posix php7-mcrypt php7-gettext \
	php7-ldap php7-ctype php7-dom php7-simplexml && \
	mkdir -p /var/www/html/adminer && \
    curl -sSL https://www.adminer.org/latest-en.php > /var/www/html/adminer/index.php && \
	adduser -S nginx &&	addgroup -S nginx

COPY ./run.sh /scripts/run.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]
