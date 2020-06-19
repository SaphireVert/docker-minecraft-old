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
cp /tmpmineserv/* $SPIGOTDIR

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
setServerProp "broadcast-rcon-to-ops" "$BROADCAST_RCON_TO_OPS"
setServerProp "view-distance" "$VIEW_DISTANCE"
setServerProp "max-build-height" "$MAX_BUILD_HEIGHT"
setServerProp "server-ip" "$SERVER_IP"
setServerProp "level-seed" "$LEVEL_SEED"
setServerProp "rcon.port" "$RCON_PORT"
setServerProp "gamemode" "$GAMEMODE"
setServerProp "server-port" "$SERVER_PORT"
setServerProp "allow-nether" "$ALLOW_NETHER"
setServerProp "enable-command-block" "$ENABLE_COMMAND_BLOCK"
setServerProp "enable-rcon" "$ENABLE_RCON"
setServerProp "enable-query" "$ENABLE_QUERY"
setServerProp "op-permission-level" "$OP_PERMISSION_LEVEL"
setServerProp "prevent-proxy-connections" "$PREVENT_PROXY_CONNECTIONS"
setServerProp "generator-settings" "$GENERATOR_SETTINGS"
setServerProp "resource-pack" "$RESOURCE_PACK"
setServerProp "level-name" "$LEVEL_NAME"
setServerProp "rcon.password" "$RCON_PASSWORD"
setServerProp "player-idle-timeout" "$PLAYER_IDLE_TIMEOUT"
setServerProp "motd" "$MOTD"
setServerProp "query.port" "$QUERY_PORT"
setServerProp "debug" "$DEBUG"
setServerProp "force-gamemode" "$FORCE_GAMEMODE"
setServerProp "hardcore" "$HARDCORE"
setServerProp "white-list" "$WHITE_LIST"
setServerProp "broadcast-console-to-ops" "$BROADCAST_CONSOLE_TO_OPS"
setServerProp "pvp" "$PVP"
setServerProp "spawn-npcs" "$SPAWN_NPCS"
setServerProp "generate-structures" "$GENERATE_STRUCTURES"
setServerProp "spawn-animals" "$SPAWN_ANIMALS"
setServerProp "snooper-enabled" "$SNOOPER_ENABLED"
setServerProp "difficulty" "$DIFFICULTY"
setServerProp "function-permission-level" "$FUNCTION_PERMISSION_LEVEL"
setServerProp "network-compression-threshold" "$NETWORK_COMPRESSION_THRESHOLD"
setServerProp "level-type" "$LEVEL_TYPE"
setServerProp "spawn-monsters" "$SPAWN_MONSTERS"
setServerProp "max-tick-time" "$MAX_TICK_TIME"
setServerProp "enforce-whitelist" "$ENFORCE_WHITELIST"
setServerProp "use-native-transport" "$USE_NATIVE_TRANSPORT"
setServerProp "max-players" "$MAX_PLAYERS"
setServerProp "resource-pack-sha1" "$RESOURCE_PACK_SHA1"
setServerProp "spawn-protection" "$SPAWN_PROTECTION"
setServerProp "online-mode" "$ONLINE_MODE"
setServerProp "allow-flight" "$ALLOW_FLIGHT"
setServerProp "max-world-size" "$MAX_WORLD_SIZE"





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
