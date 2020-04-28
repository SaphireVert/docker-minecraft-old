check-env:
ifeq ($(wildcard .env),)
	@echo "Please create your .env file first, from .env_sample"
	@exit 1
else
include .env
endif

build: check-env
	docker build --build-arg REV=${REV} -t ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot .
	docker tag ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot:latest ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot:${REV}

force-build: check-env
	docker build --no-cache --build-arg REV=${REV} -t ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot .

cp-spigot: check-env build
	docker create --rm -ti --name tmpcntr ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot bash
	docker cp tmpcntr:/spigotdir/spigot-${REV}.jar .
	docker rm -f tmpcntr

run: check-env
	docker run -e EULA=true -it ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot

exec: check-env
	docker exec -it ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot /bin/bash

push:
	docker push ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot:latest
