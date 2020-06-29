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

# Copy spigot files
cp -r /tmpmineserv/* $SPIGOTDIR

cd $SPIGOTDIR
function setFileProp {
  local prop=$1
  local var=$2
  local filePath=$3
  local fileSign=$4
  local spacesBefore=$5
  if [[ ! -f "$filePath" ]]; then
    echo "$filePath doesn't exist"
    echo "Creating $filePath file..."
    touch "$filePath"
  fi
  if [ -n "$var" ]; then
    echo "Setting $prop to $var"
    sed -i "/$prop\s*$fileSign/c\\$spacesBefore$prop$fileSign$var" $filePath
  fi
}

ls -al $SPIGOTDIR
setFileProp "broadcast-rcon-to-ops" "$BROADCAST_RCON_TO_OPS" "$SPIGOTDIR/server.properties" "="
setFileProp "view-distance" "$VIEW_DISTANCE" "$SPIGOTDIR/server.properties" "="
setFileProp "max-build-height" "$MAX_BUILD_HEIGHT" "$SPIGOTDIR/server.properties" "="
setFileProp "server-ip" "$SERVER_IP" "$SPIGOTDIR/server.properties" "="
setFileProp "level-seed" "$LEVEL_SEED" "$SPIGOTDIR/server.properties" "="
setFileProp "rcon.port" "$RCON_PORT" "$SPIGOTDIR/server.properties" "="
setFileProp "gamemode" "$GAMEMODE" "$SPIGOTDIR/server.properties" "="
setFileProp "server-port" "$SERVER_PORT" "$SPIGOTDIR/server.properties" "="
setFileProp "allow-nether" "$ALLOW_NETHER" "$SPIGOTDIR/server.properties" "="
setFileProp "enable-command-block" "$ENABLE_COMMAND_BLOCK" "$SPIGOTDIR/server.properties" "="
setFileProp "enable-rcon" "$ENABLE_RCON" "$SPIGOTDIR/server.properties" "="
setFileProp "enable-query" "$ENABLE_QUERY" "$SPIGOTDIR/server.properties" "="
setFileProp "op-permission-level" "$OP_PERMISSION_LEVEL" "$SPIGOTDIR/server.properties" "="
setFileProp "prevent-proxy-connections" "$PREVENT_PROXY_CONNECTIONS" "$SPIGOTDIR/server.properties" "="
setFileProp "generator-settings" "$GENERATOR_SETTINGS" "$SPIGOTDIR/server.properties" "="
setFileProp "resource-pack" "$RESOURCE_PACK" "$SPIGOTDIR/server.properties" "="
setFileProp "level-name" "$LEVEL_NAME" "$SPIGOTDIR/server.properties" "="
setFileProp "rcon.password" "$RCON_PASSWORD" "$SPIGOTDIR/server.properties" "="
setFileProp "player-idle-timeout" "$PLAYER_IDLE_TIMEOUT" "$SPIGOTDIR/server.properties" "="
setFileProp "motd" "$MOTD" "$SPIGOTDIR/server.properties" "="
setFileProp "query.port" "$QUERY_PORT" "$SPIGOTDIR/server.properties" "="
setFileProp "debug" "$DEBUG" "$SPIGOTDIR/server.properties" "="
setFileProp "force-gamemode" "$FORCE_GAMEMODE" "$SPIGOTDIR/server.properties" "="
setFileProp "hardcore" "$HARDCORE" "$SPIGOTDIR/server.properties" "="
setFileProp "white-list" "$WHITE_LIST" "$SPIGOTDIR/server.properties" "="
setFileProp "broadcast-console-to-ops" "$BROADCAST_CONSOLE_TO_OPS" "$SPIGOTDIR/server.properties" "="
setFileProp "pvp" "$PVP" "$SPIGOTDIR/server.properties" "="
setFileProp "spawn-npcs" "$SPAWN_NPCS" "$SPIGOTDIR/server.properties" "="
setFileProp "generate-structures" "$GENERATE_STRUCTURES" "$SPIGOTDIR/server.properties" "="
setFileProp "spawn-animals" "$SPAWN_ANIMALS" "$SPIGOTDIR/server.properties" "="
setFileProp "snooper-enabled" "$SNOOPER_ENABLED" "$SPIGOTDIR/server.properties" "="
setFileProp "difficulty" "$DIFFICULTY" "$SPIGOTDIR/server.properties" "="
setFileProp "function-permission-level" "$FUNCTION_PERMISSION_LEVEL" "$SPIGOTDIR/server.properties" "="
setFileProp "network-compression-threshold" "$NETWORK_COMPRESSION_THRESHOLD" "$SPIGOTDIR/server.properties" "="
setFileProp "level-type" "$LEVEL_TYPE" "$SPIGOTDIR/server.properties" "="
setFileProp "spawn-monsters" "$SPAWN_MONSTERS" "$SPIGOTDIR/server.properties" "="
setFileProp "max-tick-time" "$MAX_TICK_TIME" "$SPIGOTDIR/server.properties" "="
setFileProp "enforce-whitelist" "$ENFORCE_WHITELIST" "$SPIGOTDIR/server.properties" "="
setFileProp "use-native-transport" "$USE_NATIVE_TRANSPORT" "$SPIGOTDIR/server.properties" "="
setFileProp "max-players" "$MAX_PLAYERS" "$SPIGOTDIR/server.properties" "="
setFileProp "resource-pack-sha1" "$RESOURCE_PACK_SHA1" "$SPIGOTDIR/server.properties" "="
setFileProp "spawn-protection" "$SPAWN_PROTECTION" "$SPIGOTDIR/server.properties" "="
setFileProp "online-mode" "$ONLINE_MODE" "$SPIGOTDIR/server.properties" "="
setFileProp "allow-flight" "$ALLOW_FLIGHT" "$SPIGOTDIR/server.properties" "="
setFileProp "max-world-size" "$MAX_WORLD_SIZE" "$SPIGOTDIR/server.properties" "="

setFileProp "bungeecord" "$ENABLE_BUNGEECORD" "$SPIGOTDIR/spigot.yml" ": " "  "





function writeFile {
  local text=$1
  local filePath=$2
  echo $text > $filePath
}

writeFile "$OPS" "$SPIGOTDIR/ops.txt"



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
