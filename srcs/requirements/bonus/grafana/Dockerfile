FROM alpine:3.15

RUN apk update && \
    apk add --no-cache dumb-init grafana

COPY ./run.sh /scripts/run.sh
# COPY ./grafana.ini /usr/share/grafana/conf/default.ini

WORKDIR /usr/share/grafana

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]