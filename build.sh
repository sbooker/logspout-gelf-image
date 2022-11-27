#!/bin/sh
set -e
apk update
apk add --no-cache --update go build-base git mercurial ca-certificates pcre2-dev
cd /src
go get github.com/sbooker/logspout-gelf@1.1.2
go build -ldflags "-X main.Version=$1" -o /bin/logspout
apk del go git mercurial build-base
rm -rf /root/go /var/cache/apk/*

# backwards compatibility
ln -fs /tmp/docker.sock /var/run/docker.sock