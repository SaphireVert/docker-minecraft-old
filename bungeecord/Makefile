reset: check-env
	$(MAKE) clean
	$(MAKE) build
	$(MAKE) up

clean:
	sudo rm -rf data/*

inside:
  docker run -it docker-bungeecord /bin/bash

build:
	docker build -t saphirevert/docker-bungeecord .
