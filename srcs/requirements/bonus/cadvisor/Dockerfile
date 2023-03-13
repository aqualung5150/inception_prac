FROM alpine:3.16

RUN apk update && \
    apk add --no-cache dumb-init curl && \
    curl -L https://github.com/google/cadvisor/releases/download/v0.47.0/cadvisor-v0.47.0-linux-amd64 -o /usr/bin/cadvisor && \
    chmod +x /usr/bin/cadvisor

COPY ./run.sh /scripts/run.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]