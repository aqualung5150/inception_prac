FROM alpine:3.15

RUN apk update && \
    apk add --no-cache dumb-init grafana

COPY ./run.sh /scripts/run.sh
COPY ./datasource.yml /usr/share/grafana/conf/provisioning/datasources/datasource.yml
COPY ./dashboard.yml /usr/share/grafana/conf/provisioning/dashboards/dashboard.yml
COPY ./my_dash.json /var/lib/grafana/dashboards/my_dash.json
COPY ./grafana.ini /usr/share/grafana/conf/defaults.ini

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]