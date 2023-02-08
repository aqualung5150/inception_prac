FROM	alpine:3.14

RUN	apk update && \ 
	apk add --no-cache dumb-init mariadb mariadb-client mariadb-server-utils && \
	rm -rf /var/cache/apk/*

COPY	./run.sh /scripts/run.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]
