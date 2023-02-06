FROM	alpine:3.16

RUN	apk update && \ 
	apk add --no-cache dumb-init mariadb mariadb-client mariadb-server-utils && \
	rm -f /var/cache/apk/*

COPY	files/run_1.sh /scripts/run.sh
COPY	files/query.sql /tmp/query.sql

ENTRYPOINT ["/usr/bin/dumb-init","--"]

CMD ["sh", "/scripts/run.sh"]
