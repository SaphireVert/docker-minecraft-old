#!/usr/bin/env bash
set -e -x
# echo "Hello from spigot.sh"

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
function setServerProp {
  if [[ ! -f "$SPIGOTDIR/server.properties" ]]; then
    echo "Server.properties doesn't exists"
    echo "Creating server.properties file..."
    touch server.properties
  fi
  local prop=$1
  local var=$2
  if [ -n "$var" ]; then
    echo "Setting $prop to $var"
    sed -i "/$prop\s*=/ c $prop=$var" $SPIGOTDIR/server.properties
  fi
}

ls -al $SPIGOTDIR
setServerProp "motd" "$MOTD"








# Ensure that final direcories exist
# [ -d $SPIGOTDIR/worlds ] || mkdir $SPIGOTDIR/worlds
# Manage the Multiverse plugin
echo "Force download is set to: $FORCE_DOWNLOAD"
if [[ ! -f $SPIGOTDIR/plugins/Multiverse-Core-4.1.1-SNAPSHOT.jar || "$FORCE_DOWNLOAD" == "true" ]]; then
  echo "Downloading Multiverse..."
  [ -d $SPIGOTDIR/plugins ] || mkdir $SPIGOTDIR/plugins
  wget http://ci.onarandombox.com/job/Multiverse-Core/lastBuild/artifact/target/Multiverse-Core-4.1.1-SNAPSHOT.jar -P $TEMPDIR/plugins/
  # Install plugin multiverse
  mv $TEMPDIR/plugins/* $SPIGOTDIR/plugins
else
  echo "Multiverse is already here"
fi

# Copy spigot
cp /spigot/spigot.jar $SPIGOTDIR/spigot.jar
#
# Final step: launch the Spigot server
#
# Note: use `java -jar spigot.jar --help` for spigot options list
cd $SPIGOTDIR
echo -e "Launching the command:\njava -jar -Xms$XMS -Xmx$XMX spigot.jar -W $SPIGOTDIR/data/worlds nogui"
java -jar -Xms$XMS -Xmx$XMX spigot.jar \
     -W $SPIGOTDIR/worlds nogui
