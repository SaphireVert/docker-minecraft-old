check-env:
ifeq ($(wildcard .env),)
	@echo "Please create your .env file first, from .env_sample"
	@exit 1
else
include .env
endif

# Clear server data and rebuild the server
reset: check-env
	# TODO: add a warning, because it clear the data directory !

	./library.sh yesNoReset "Are you sure you want to reset all server ? All data will be lost, continue ? [y/N]"

# Clear all server data
clear:
	# TODO: add a warning, because it clear the data directory !
	./library.sh yesNoClear "All your server data will be lost! Continue ? [y/N]"

# Go in the spigot docker container
inside-sp:
	docker-compose run spigotmc /bin/bash

# Go in the bungeecord docker container
inside-bc:
	docker-compose run bungeecord /bin/bash

# Start the server
up:
	docker-compose up

# Start the server (detached)
up-d:
	docker-compose up -d

# Build both Spigot and BungeeCord
build: check-env
	@echo "\n  :: Build Spigot container ::\n"
	$(MAKE) build-sp
	#echo "Build Bungeecord container"
	#$(MAKE) build-bc

# Build Spigot but ensure a change in ./spigot/Dockerfile in order to reload
# spigot.sh in the image — for development purpose.
rebuild-sp:
	TIMESTAMP=$(shell date +"%Y-%m-%d_%H:%M:%S") && \
	sed -i "/RUN echo \"spigot/ c RUN echo \"spigot $$TIMESTAMP\"" ./spigot/Dockerfile
	$(MAKE) build-sp

# Build Spigot container
build-sp: check-env
	docker build --build-arg REV=${REV} -t ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot ./spigot
	docker tag ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot:latest ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot:${REV}

# Build BungeeCord container
#build-bc: check-env
#	docker build -t ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}bungeecord ./bungeecord

force-build: check-env
	docker build --no-cache --build-arg REV=${REV} -t ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot ./spigot

# Retrieve the spigot-version.jar from a temporary container
cp-spigot: check-env build
	docker create --rm -ti --name tmpcntr ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot bash
	docker cp tmpcntr:${$SPIGOTDIR}/spigot-${REV}.jar .
	docker rm -f tmpcntr

# Run spigot server only
run: check-env
	docker run -e EULA=true -it ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot

# Enter in running spigo container
exec: check-env
	docker exec -it ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot /bin/bash

# Docker push
push: check-env
	docker push ${DOCKER_HUB_USERNAME}/${IMG_PREFIX}spigot:latest
