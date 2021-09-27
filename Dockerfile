# Build
FROM golang:1.17-alpine AS build-env
RUN apk add build-base
RUN go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest
RUN go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-server@latest

# Release
FROM alpine:3.14
RUN apk -U upgrade --no-cache \
    && apk add --no-cache bind-tools ca-certificates
COPY --from=build-env /go/bin/interactsh-client /usr/local/bin/interactsh-client
COPY --from=build-env /go/bin/interactsh-server /usr/local/bin/interactsh-server

ENTRYPOINT ["/usr/bin/env"]