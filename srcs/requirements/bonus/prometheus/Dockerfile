FROM alpine:3.15

RUN apk update && \
    apk add --no-cache dumb-init prometheus

COPY ./prometheus.yml /etc/prometheus/prometheus.yml
COPY ./run.sh /scripts/run.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]