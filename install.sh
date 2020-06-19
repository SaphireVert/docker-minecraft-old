#!/usr/bin/env bash

# See https://github.com/SaphireVert/scalewayMinecraftServ/issues/10
# TODO:
# [ ] Add a welcome header
# [x] Check that all dependencies are installed, e.g. tmux, git, etc...
# [x] Clone this repo and cd into dir (see https://unix.stackexchange.com/a/97922)
# [x] cp .env_sample to .env
# [~] ask question to change the .env file (wizard)
# [x] launch the server
# [ ] finally, launch the server in a tmux process (see https://unix.stackexchange.com/questions/22682/how-to-launch-a-set-of-program-inside-tmux-or-gnome-terminal-within-a-script etc.)
#

# The aim of this script is to be ran with the command
# curl -s -L https://raw.githubusercontent.com/saphirevert/scalewayMinecraftServ/install.sh | bash -s
# directly on the server on which one want to deploy a Minecraft server.
#

set -e -x

function header {
  echo -e "\e[32mHello from scalewayMinecraftServ"
}

header

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

check_requirements git tmux docker docker-compose

function clone_repos {
  # TODO: confirm current path to clone repo
  if ! [[ -d "scalewayMinecraftServ" ]]; then
    git clone "$1" && cd "$(basename "$1" .git)"
    pwd
  else
    cd scalewayMinecraftServ && git pull --rebase
  fi
}
clone_repos https://github.com/saphirevert/scalewayMinecraftServ

function ensure_dotenv_present {
  if ! [[ -f ".env" ]]; then
    echo "Creating the file '.env' based on '.env_sample'"
    cp .env_sample .env
  else
    echo "The file '.env' is already present"
  fi
}
ensure_dotenv_present

function set_the_motd {
  read -p "Please enter the MOTD of the server [Default: A minecraft server]:" motd
  motd=${motd:-'A minecraft server'}
  echo $motd
  sed -i "/MOTD=/ c MOTD=$motd" .env
}

set_the_motd

function build_docker_image {
  make build-sp
}

build_docker_image

function run_server {
  make up
}

run_server
