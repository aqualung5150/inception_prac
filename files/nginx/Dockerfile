FROM alpine:3.15

RUN apk update && \
    apk add --no-cache dumb-init nginx openssl

# openssl: https://lecor.tistory.com/51

COPY	./run.sh /scripts/run.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]