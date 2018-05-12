#!/bin/bash

#################################################################
### PROJECT:
### Densify
### VERSION:
### v0.1.0
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

chmod a+x densify
chmod a+x densify.desktop
cp densify.desktop /usr/share/applications/
echo "Installation Complete. If you don't see any errors above, you are good to go! :)"
