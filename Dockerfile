FROM golang:1.14.15-alpine3.11 AS build-env
RUN set -ex && \
    apk add --update --no-cache git && \
    go get -v github.com/prometheus-community/bind_exporter

FROM alpine:3.14.2

COPY --from=build-env /go/bin/bind_exporter /usr/local/bin/
EXPOSE 9119
CMD bind_exporter -bind.stats-url $URI
