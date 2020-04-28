include .env

build:
		docker build -t saphirevert/testdockerspigot .
run:
		docker run -it saphirevert/testdockerspigot
exec:
		docker exec -it saphirevert/testdockerspigot /bin/bash

testArg:
	@echo ${REV}
	@echo "Using the default value in Dockerfile ARG"
	docker build --no-cache -t ${DH_USER}/test -f test/Dockerfiletest .
	@echo "Using the build-arg value from the .env file"
	docker build --no-cache --build-arg REV=${REV} -t ${DH_USER}/test -f test/Dockerfiletest .
