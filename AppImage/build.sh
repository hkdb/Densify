#!/usr/bin/env bash

cp ../densify src/
cp ../__init__.py src/

# Create Build Directory
mkdir -p build && cd build

# Grab AppImageTools
wget -nc "https://raw.githubusercontent.com/TheAssassin/linuxdeploy-plugin-conda/master/linuxdeploy-plugin-conda.sh"
wget -nc "https://raw.githubusercontent.com/linuxdeploy/linuxdeploy-plugin-gtk/master/linuxdeploy-plugin-gtk.sh"
wget -nc "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage"
wget -nc "https://github.com/AppImage/AppImageKit/releases/download/12/appimagetool-x86_64.AppImage"
chmod +x linuxdeploy-x86_64.AppImage linuxdeploy-plugin-conda.sh appimagetool-x86_64.AppImage linuxdeploy-plugin-gtk.sh

# Generate .desktop
cat > ../res/densify.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Densify
GenericName=PDF Compressor
Comment=GUI Wrapper for Compressing PDFs with GhostScript
Icon=desktop-icon
Exec=densify
Terminal=false
Categories=Utility;
EOF

# Install App
install -D -m 755 ../src/header.png ./AppDir/opt/Densify/header.png
install -D -m 755 ../src/icon.png ./AppDir/opt/Densify/icon.png
install -D -m 755 ../src/densify ./AppDir/opt/Densify/densify
install -D -m 755 ../src/__init__.py ./AppDir/opt/Densify/__init__.py

# Set Environment
export CONDA_CHANNELS='conda-forge'
export CONDA_PACKAGES="--file=../conda.yml"
export PIP_REQUIREMENTS='PyGObject pathlib pycairo cffi'
export DEPLOY_GTK_VERSION='3'
# export CONDA_PYTHON_VERSION='3.12.14'

# Deploy
./linuxdeploy-x86_64.AppImage \
   --appdir AppDir \
    -i ../res/desktop-icon.png \
    -d ../res/densify.desktop \
    --plugin gtk \
    --plugin conda \
    --custom-apprun ../src/AppRun.sh \
    --output appimage \
    --icon-file ../res/desktop-icon.png \
    --desktop-file ../res/densify.desktop

# Prepare Script to Sign
cp ../src/signAppImage.sh .
