#!/usr/bin/env bash
set -e -x
echo "Hello from spigot.sh"

if [ -e $EULA ]; then
  echo "Please accept the EULA"
else
  if [ "$EULA" = "true" ]; then
    echo "Accepting the EULA"
    echo "eula=true" > $SPIGOTDIR/eula.txt
  else
    echo "Please accept the EULA"
  fi
fi

# Fallback default param
if [ -e $XMS ]; then
  XMS=1G
fi
if [ -e $XMX ]; then
  XMX=1G
fi

cd $SPIGOTDIR
ls -al
pwd

#Install plugin multiverse
cp /install/Multiverse-Core-*-SNAPSHOT.jar $SPIGOTDIR/data/plugins

echo "java -jar -Xms$XMS -Xmx$XMX spigot.jar -c $SPIGOTDIR/data/server.properties -P $SPIGOTDIR/data/plugins -W $SPIGOTDIR/data/worlds nogui"
# java -jar -Xms$XMS -Xmx$XMX spigot.jar \
#   -c $SPIGOTDIR/data/server.properties \
#   -P $SPIGOTDIR/data/plugins \
#   -W $SPIGOTDIR/data/worlds nogui
java -jar -Xms256M -Xmx1G spigot.jar -c /minecraft/data/server.properties -P /minecraft/data/plugins -W /minecraft/data/worlds --nogui
#--noconsole --nojline
