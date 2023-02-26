FROM alpine:3.15

RUN apk update && \
    apk add --no-cache dumb-init grafana

COPY ./run.sh /scripts/run.sh
# COPY ./grafana.ini /etc/grafana.ini
COPY ./grafana.ini /usr/share/grafana/conf/defaults.ini

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]