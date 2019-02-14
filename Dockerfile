FROM golang:1.11.5-alpine as builder

RUN apk add --no-cache --update alpine-sdk
RUN git clone https://github.com/dexidp/dex
RUN cd dex && make bin/example-app


FROM alpine:3.8
RUN apk add --update ca-certificates openssl
COPY --from=builder /go/dex/bin/example-app /usr/local/bin/example-app

WORKDIR /

ENTRYPOINT ["example-app"]