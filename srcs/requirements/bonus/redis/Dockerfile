FROM alpine:3.16

RUN apk update && \
    apk add --no-cache dumb-init redis

COPY ./run.sh /scripts/run.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]