#!/usr/bin/env bash

# See https://github.com/SaphireVert/docker-minecraft/issues/10
# TODO:
# [x] Add a welcome header
# [x] Check that all dependencies are installed, e.g. tmux, git, etc...
# [x] Clone this repo and cd into dir (see https://unix.stackexchange.com/a/97922)
# [x] cp .env_sample to .env
# [~] ask question to change the .env file (wizard)
# [x] launch the server
# [x] finally, launch the server in a tmux process (see https://unix.stackexchange.com/questions/22682/how-to-launch-a-set-of-program-inside-tmux-or-gnome-terminal-within-a-script etc.)

# The aim of this script is to be ran with the command
# curl -s -L https://raw.githubusercontent.com/saphirevert/docker-minecraft/install.sh | bash -s
# directly on the server on which one want to deploy a Minecraft server.
#

set -e -x

function header {
  echo -e "\e[32mHello from docker-minecraft"
}

function check_requirements {
  for app in "$@"
  do
    if ! [[ "$(command -v $app)" ]]; then
      echo -e "\e[31mWARNING:\e[39m $app is not installed";
      echo -e "\e[34mCOMMAND:\e[39m sudo apt install $app";
      exit 1;
    fi
  done
}

function check_group_docker {
  if [ "echo $(grep "docker" /etc/group | grep ${USER})" = "" ]; then
   echo "Docker group dosesn't exist or you're not in it."
   echo "You might try the following commands:"
   echo "sudo groupadd docker"
   echo "sudo usermod -aG docker ${USER}"
  fi
}

function clone_repos {
  # TODO: confirm current path to clone repo
  if ! [[ -d "docker-minecraft" ]]; then
    git clone "$1" && cd "$(basename "$1" .git)"
    pwd
  else
    cd docker-minecraft
    # TODO: it would be nice to `git pull`
  fi
}

function ensure_dotenv_present {
  if ! [[ -f ".env" ]]; then
    echo "Creating the file '.env' based on '.env_sample'"
    cp .env_sample .env
  else
    echo "The file '.env' is already present"
  fi
}

function set_the_motd {
  read -p "Please enter the MOTD of the server [Default: A minecraft server]:" motd
  motd=${motd:-'A minecraft server'}
  echo $motd
  sed -i "/MOTD=/ c MOTD=$motd" .env
}

function build_docker_image {
  make build-sp
}

function run_server {
  tmux new-session "make up; read"\; split-window "htop"\; select-layout even-horizontal;
}

function run {
  header
  check_requirements git tmux docker docker-compose
  check_group_docker
  clone_repos https://github.com/saphirevert/docker-minecraft
  ensure_dotenv_present
  set_the_motd
  build_docker_image
  run_server
}

run
