FROM golang:1.15.5-alpine3.12 AS builder
WORKDIR /code
COPY . .
RUN go build

FROM alpine:3.12

RUN apk add -U ca-certificates tzdata mailcap && rm -Rf /var/cache/apk/*
COPY --from=builder /code/selenoid /usr/bin

EXPOSE 4444
ENTRYPOINT ["/usr/bin/selenoid", "-listen", ":4444", "-conf", "/etc/selenoid/browsers.json", "-video-output-dir", "/opt/selenoid/video/"]
