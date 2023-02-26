FROM alpine:3.15

RUN	apk update && \ 
	apk add --no-cache dumb-init mariadb mariadb-client mariadb-server-utils

COPY ./run.sh /scripts/run.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]