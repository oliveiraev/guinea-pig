# vim: set ai si sta et sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=dockerfile:

FROM alpine:3.10.1 AS deps
RUN apk update \
&&  apk add --no-cache \
        g++=8.3.0-r0 \
        gcc=8.3.0-r0 \
        gzip=1.10-r0 \
        make=4.2.1-r2 \
        tar=1.32-r0 \
        wget=1.20.3-r0

