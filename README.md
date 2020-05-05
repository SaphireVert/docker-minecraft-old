<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [scalewayMinecraftServ](#scalewayminecraftserv)
- [TODO](#todo)

<!-- /TOC -->
# scalewayMinecraftServ
Héberger des serveurs Minecraft chez un prestataire spécialisé c'est bien, le faire from scratch, c'est mieux !

# TODO
- [x] Makefile: push image
- [x] Finish docker-compose file,
- [x] Add env variable in docker-compose file for /spigot.sh
- [ ] Ne pas redownloader spigot si déjà downloadé
- [ ] Option pour force download
- [ ] Pouvoir taper commandes dans la console du serveur
- [ ] Pouvoir set les propriétés de server.properties dans .env
- [ ] Trouver qui a la priorité pour les variables d'env entre .env, docker-compose up et le makefile (avec motd)
