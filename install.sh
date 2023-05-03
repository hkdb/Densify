#!/bin/bash

#################################################################
### PROJECT:
### Squeezer
### VERSION:
### v0.1.0
### SCRIPT:
### install.sh
### DESCRIPTION:
### Install Script for Squeezer
### MAINTAINED BY:
### Mariano Marini <mariano.marini@mail.com>
### Disclaimer:
### This application is maintained by volunteers and in no way
### do the maintainers make any guarantees. Use at your own risk.
### ##############################################################

chmod a+x squeezer
chmod a+x squeezer.desktop
mkdir -p /opt/Squeezer
cp squeezer /opt/Squeezer
cp *.png /opt/Squeezer
cp squeezer.desktop /usr/share/applications/
cp squeezer.mo /usr/share/locale/it/LC_MESSAGES/
echo "Installation Complete. If you don't see any errors above, you are good to go! :)"
