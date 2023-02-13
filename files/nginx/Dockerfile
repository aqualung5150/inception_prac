FROM alpine:3.15

RUN apk update && \
    apk add --no-cache dumb-init nginx openssl && \
    mkdir -p /run/nginx /etc/nginx/ssl && \
    # openssl genrsa 2048 > /etc/nginx/ssl/privatekey.pem && \
    # openssl req -new -key /etc/nginx/ssl/privatekey.pem -out /etc/nginx/ssl/csr.pem -subj "/CN=seunchoi.42.fr/O=42seoul/OU=42seoul/L=seoul/ST=seoul/C=KR/" && \
    # openssl x509 -req -days 365 -in /etc/nginx/ssl/csr.pem -signkey /etc/nginx/ssl/privatekey.pem -out /etc/nginx/ssl/public.crt
    # https://docs.aws.amazon.com/ko_kr/elasticbeanstalk/latest/dg/configuring-https-ssl.html
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/public.crt \
        -keyout /etc/nginx/ssl/privatekey.pem \
        -subj "/C=KR/ST=Seoul/L=Seoul/O=42seoul/OU=seunchoi/CN=seunchoi.42.fr/"

COPY ./nginx.conf /etc/nginx/http.d/default.conf
COPY	./run.sh /scripts/run.sh

EXPOSE      443

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "/scripts/run.sh"]
# CMD ["nginx", "-g", "daemon off;"]