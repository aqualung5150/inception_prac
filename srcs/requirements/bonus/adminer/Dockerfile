FROM alpine:3.16

# Install required php packages and wp-cli
RUN apk update && \
	apk add --no-cache dumb-init curl \
	php8 php8-phar php8-fpm php8-common php8-session php8-iconv php8-json \
	php8-gd php8-curl php8-xml php8-mysqli php8-imap \
	php8-cgi fcgi php8-pdo php8-pdo_mysql php8-soap \
	php8-posix php8-gettext \
	php8-ldap php8-ctype php8-dom php8-simplexml && \
	mkdir -p /var/www/html/adminer && \
    curl -sSL https://www.adminer.org/latest-en.php > /var/www/html/adminer/index.php && \
	adduser -S nginx &&	addgroup -S nginx

COPY ./run.sh /scripts/run.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]
