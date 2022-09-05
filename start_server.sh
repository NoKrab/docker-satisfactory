#!/bin/bash
export InstallationDir=/home/steam/SatisfactoryDedicatedServer
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$InstallationDir/linux64:$LD_LIBRARY_PATH
# Install or update the server before launching it
/usr/games/steamcmd +force_install_dir $InstallationDir +login anonymous +app_update 1690800 -beta experimental validate +quit
# Launch the server
$InstallationDir/FactoryServer.sh
export LD_LIBRARY_PATH=$templdpath
