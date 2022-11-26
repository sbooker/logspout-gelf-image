ARGS=$(filter-out $@,$(MAKECMDGOALS))

IMAGE=sergebooker/logspout-gelf

guard-%:
	@ if [ "${${*}}" = "" ]; then \
  		echo "Enviroment variable $* not set"; \
  		exit 1; \
  	fi

up:
	docker compose up --build

stop:
	docker compose stop

restart: stop up

all: build push

build: guard-TAG guard-IMAGE
	docker build --no-cache -t ${IMAGE}:${TAG} .

push: guard-TAG guard-IMAGE
	docker push ${IMAGE}:${TAG}

tag-to: guard-TAG guard-IMAGE guard-TAG_TO
	docker image tag ${IMAGE}:${TAG} ${IMAGE}:${TAG_TO}