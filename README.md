# scalewayMinecraftServ

Héberger des serveurs Minecraft chez un prestataire spécialisé c'est bien, le
faire from scratch, c'est mieux !

<!-- TOC titleSize:2 tabSpaces:2 depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 skip:0 title:1 charForUnorderedList:* -->
## Table of Contents
* [scalewayMinecraftServ](#scalewayminecraftserv)
* [Setup](#setup)
  * [Quick setup (good for n00bs)](#quick-setup-good-for-n00bs)
* [For confirmed users](#for-confirmed-users)
  * [Requirements](#requirements)
  * [Install server](#install-server)
* [Development](#development)
* [Understand](#understand)
<!-- /TOC -->

# Setup

## Quick setup (good for n00bs)

Open a terminal and type:
```
curl -s -L https://raw.githubusercontent.com/saphirevert/scalewayMinecraftServ/install.sh | bash -s
```

Note: this assumes that your are on a [Debian
like](https://www.debian.org/derivatives/) operating system that uses `apt`.

# For confirmed users

## Requirements
- Linux (debian like distros, needs apt)
- Docker, docker-compose, make, tmux

## Install server
  1. Get the code: `git clone https://github.com/saphirevert/scalewayMinecraftServ`;
  1. Enter the directory: `cd scalewayMinecraftServ`;
  1. Duplicate the sample environment: `cp .env_sample .env`;
  1. Edit the `.env` file and set your own values;
  1. Build the docker containers: `make build`;
  1. Launch the server with `make up` and enjoy!

# Development

// TODO


# Understand

// TODO
