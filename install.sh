#!/usr/bin/env bash

# See https://github.com/SaphireVert/scalewayMinecraftServ/issues/10
# TODO:
# [ ] Add a welcome header
# [ ] Check that all dependencies are installed, e.g. tmux, git, etc...
# [ ] Clone this repo and cd into dir (see https://unix.stackexchange.com/a/97922)
# [ ] cp .env_sample to .env
# [ ] ask question to change the .env file (wizard)
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
