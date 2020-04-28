include .env

build:
	docker build --build-arg REV=${REV} -t ${DH_USER}/${IMG_PREFIX}spigot .

force-build:
	docker build --no-cache --build-arg REV=${REV} -t ${DH_USER}/${IMG_PREFIX}spigot .

cp-spigot: build
	docker create --rm -ti --name tmpcntr ${DH_USER}/${IMG_PREFIX}spigot bash
	docker cp tmpcntr:/spigotdir/spigot-${REV}.jar .
	docker rm -f tmpcntr

run:
	docker run -it ${DH_USER}/${IMG_PREFIX}spigot

exec:
	docker exec -it ${DH_USER}/${IMG_PREFIX}spigot /bin/bash

testArg:
	@echo ${REV}
	@echo "Using the default value in Dockerfile ARG"
	docker build --no-cache -t ${DH_USER}/test -f test/Dockerfiletest .
	@echo "Using the build-arg value from the .env file"
	docker build --no-cache --build-arg REV=${REV} -t ${DH_USER}/test -f test/Dockerfiletest .
