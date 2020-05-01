# Logspout with GELF adapter and message parser

This image based on official [Logspout](https://github.com/gliderlabs/logspout) image and add GELF adapter 
with [Monolog](https://github.com/Seldaek/monolog) default format message parsing  

## Usage

Remember to set the hostname of the container to something meaningfull, because that gets set as the source of the GELF message.

### Message format
See [parser documentation](https://github.com/sbooker/logspout-gelf#message-format)

### Enviroment variables
See [documentation](https://github.com/sbooker/logspout-gelf#environment-variables)

### CLI example

```bash
docker run -d --name=logspout --restart=unless-stopped -h $(hostname -f) \
    -v /var/run/docker.sock:/var/run/docker.sock \
    sbooker/logspout-gelf \
    gelf://my.log.server:12201
```

### Docker Compose example

You could use this image with the following docker-compose file:

```
version: '3.4'

services:
  logspout:
    labels:
      - "logspout.exclude=true"
    build:
      context: .
    environment:
      COMPRESS_TYPE: "none"
      COMPRESS_LEVEL: "0"
      EXCLUDE_LABEL: "logspout.exclude"
      EXTRA_JSON: "{\"env\":\"environment\"}"
    hostname: some.host
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    command: multiline+gelf://host.docker.internal:4001
    restart: unless-stopped
```
 






