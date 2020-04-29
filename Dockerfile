FROM alpine:3.11.6

RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
        git \
        bash \
        gcc \
        musl-dev \
        openssl \
        go \
        curl \
    \
    && go get -v github.com/digitalocean/bind_exporter \
    && cp /root/go/bin/bind_exporter /usr/local/bin \
    && rm -fr /root/go \
    && apk del .build-deps

EXPOSE 9119

CMD bind_exporter -bind.stats-url $URI
