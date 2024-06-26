#!/bin/bash

#################################################################
### PROJECT:
### Densify
### VERSION:
### v0.3.2
### SCRIPT:
### install.sh
### DESCRIPTION:
### Install Script for Densify
### MAINTAINED BY:
### hkdb <hkdb@3df.io>
### Disclaimer:
### This application is maintained by volunteers and in no way
### do the maintainers make any guarantees. Use at your own risk.
### ##############################################################

VER="v0.12"
CYAN='\033[0;36m'
GREEN='\033[1;32m'
NC='\033[0m' 

USEROS=""
echo -e "🐧️ Detecting OS..."
if [[ "$OSTYPE" == "linux"* ]]; then
  USEROS="linux"
  echo -e "\n🐧️ Linux\n"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  USEROS="freebsd"
  echo -e "\n🅱️  FreeBSD\n"
else
  echo -e "❌️ Operating System not supported... Exiting...\n"
  exit 1
fi

echo -e "💻️ Detecting CPU arch...\n"

CPUARCH=""
UNAMEM=$(uname -m)
echo -e "🏰️: $UNAMEM\n"

if [[ "$UNAMEM" == "x86_64" ]] || [[ "$UNAMEM" == "amd64" ]]; then
  CPUARCH="amd64"
else
  echo -e "❌️ CPU Architecture not supported... Exiting...\n"
  exit 1
fi

echo -e "🚀️ Installing Densify...\n"
chmod +x densify
chmod +x densify.desktop
mkdir -p /opt/Densify
cp densify /opt/Densify
cp *.png /opt/Densify
cp densify.desktop /usr/share/applications/

echo -e "\n${GREEN}**************"
echo -e " 💯️ COMPLETED"
echo -e "**************${NC}\n"


echo "Installation Complete. If you don't see any errors above, you are good to go! :)"
