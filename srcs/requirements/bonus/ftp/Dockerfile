FROM alpine:3.16

RUN apk update && \
    apk add --no-cache dumb-init vsftpd

COPY ./run.sh /scripts/run.sh
COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]