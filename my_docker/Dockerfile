FROM	alpine:3.13

RUN	apk update && \ 
	apk add --no-cache dumb-init mariadb mariadb-client mariadb-server-utils

COPY	files/run.sh /scripts/run.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]
