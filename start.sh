#!/usr/bin/env bash

# set -e -x
set -x

sudo apt-get update -y && apt upgrade -y
sudo apt-get install docker docker-compose make
cp .env_sample .env


echo hey
if [ "echo $(grep "docker" /etc/group | grep ${USER})" = "" ]; then
  echo "Pas de groupe docker ou bien vous n'êtes pas dedans"
  echo "Ajout de vous dans le groupe docker en cours"
  sudo groupadd docker
  sudo usermod -aG docker ${USER}
fi

make build-sp up


echo fini

# sudo reboot

# ajouter .env en copiant .env_sample
# installer make docker docker-compose
# docker socket
#recommander utilisation tmux






# grep -oP "(\?|&)${USER}=\K([0-9]+)" /etc/group
