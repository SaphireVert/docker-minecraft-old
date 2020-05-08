<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [scalewayMinecraftServ](#scalewayminecraftserv)
- [TODO](#todo)

<!-- /TOC -->
# scalewayMinecraftServ
Héberger des serveurs Minecraft chez un prestataire spécialisé c'est bien, le faire from scratch, c'est mieux !

# Installation
## Pré requis :
- Linux
- Docker, docker-compose

## Téléchargement
- Cloner le repos github





# TODO
- [x] Makefile: push image
- [x] Finish docker-compose file,
- [x] Add env variable in docker-compose file for /spigot.sh
- [x] Ne pas redownloader plugin si déjà downloadé
- [x] Option pour force download
- [x] Trouver qui a la priorité pour les variables d'environnement entre .env, docker-compose up et le makefile (avec motd par exemple)
- [ ] Pouvoir set les propriétés de server.properties dans .env
- [ ] Pouvoir taper commandes dans la console du serveur
