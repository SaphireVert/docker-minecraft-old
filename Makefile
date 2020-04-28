check-env:
ifeq ($(wildcard .env),)
	@echo "Please create your .env file first, from .env_sample"
	@exit 1
else
include .env
endif

build: check-env
	docker build --build-arg REV=${REV} -t ${DH_USER}/${IMG_PREFIX}spigot .
	docker tag ${DH_USER}/${IMG_PREFIX}spigot:latest ${DH_USER}/${IMG_PREFIX}spigot:${REV}

force-build: check-env
	docker build --no-cache --build-arg REV=${REV} -t ${DH_USER}/${IMG_PREFIX}spigot .

cp-spigot: check-env build
	docker create --rm -ti --name tmpcntr ${DH_USER}/${IMG_PREFIX}spigot bash
	docker cp tmpcntr:/spigotdir/spigot-${REV}.jar .
	docker rm -f tmpcntr

run: check-env
	docker run -e EULA=true -it ${DH_USER}/${IMG_PREFIX}spigot

exec: check-env
	docker exec -it ${DH_USER}/${IMG_PREFIX}spigot /bin/bash

push:
	docker push ${DH_USER}/${IMG_PREFIX}spigot:latest

testArg: check-env
	@echo ${REV}
	@echo "Using the default value in Dockerfile ARG"
	docker build --no-cache -t ${DH_USER}/test -f test/Dockerfiletest .
	@echo "Using the build-arg value from the .env file"
	docker build --no-cache --build-arg REV=${REV} -t ${DH_USER}/test -f test/Dockerfiletest .
