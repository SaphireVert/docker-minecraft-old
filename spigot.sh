#!/usr/bin/env bash

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

java -jar -Xms$XMS -Xmx$XMX spigot.jar
