FROM alpine:3.15

RUN apk update && \
    apk add --no-cache dumb-init grafana

COPY ./run.sh /scripts/run.sh
<<<<<<< HEAD
# COPY ./grafana.ini /etc/grafana.ini
COPY ./grafana.ini /usr/share/grafana/conf/defaults.ini
=======
COPY ./grafana.ini /etc/grafana.ini
>>>>>>> 1ce7164a1463506d57be95e29ca5bbb9e086088b

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]