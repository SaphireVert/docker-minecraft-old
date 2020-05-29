<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [scalewayMinecraftServ](#scalewayminecraftserv)
- [TODO](#todo)

<!-- /TOC -->
# scalewayMinecraftServ
Héberger des serveurs Minecraft chez un prestataire spécialisé c'est bien, le faire from scratch, c'est mieux !

# Setup
## For NUBS :
Open a terminal and type :
<!-- curl -s -L https://raw.githubusercontent.com/epfl-dojo/dojo-like-script/master/run.sh | bash -s -- -o=epfl-si -->



For the confirmed users :

## Required :
- Linux
- Docker, docker-compose, make, tmux

## Install server
- git clone
- cd scalewayMinecraftServ
- cp .env_sample .env
- ```make build up``` and enjoy !


# BungeeCord :
## On Spigot server files
Download and launch BungeeCord :
Set the online mode false in the serser.properties server's files
Set the propertie bungeecord: true in the spigot.yml file

## On BungeeCord config file :
Set the lobby server address propertie with the spigot server address
