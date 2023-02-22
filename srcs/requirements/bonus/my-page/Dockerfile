FROM alpine:3.15 AS builder

RUN apk update && \
    apk add --no-cache nodejs npm && \
    mkdir /app

WORKDIR /app

COPY ./app/package.json /app/package.json
RUN npm install --silent

COPY ./app /app
RUN npm run build

FROM alpine:3.15

RUN apk update && \
    apk add --no-cache dumb-init nginx

COPY ./nginx.conf /etc/nginx/http.d/default.conf
COPY --from=builder /app/build /var/www/html/build
COPY ./run.sh /scripts/run.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]