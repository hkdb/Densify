#!/usr/bin/env bash

# Create Build Directory
mkdir -p build && cd build

# Grab AppImageTools
wget -nc "https://raw.githubusercontent.com/TheAssassin/linuxdeploy-plugin-conda/master/linuxdeploy-plugin-conda.sh"
wget -nc "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage"
wget -nc "https://github.com/AppImage/AppImageKit/releases/download/12/appimagetool-x86_64.AppImage"
chmod +x linuxdeploy-x86_64.AppImage linuxdeploy-plugin-conda.sh appimagetool-x86_64.AppImage

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

# Set Environment
export CONDA_CHANNELS='local;conda-forge'
export PIP_REQUIREMENTS='PyGObject pathlib'

# Deploy
./linuxdeploy-x86_64.AppImage \
   --appdir AppDir \
    -i ../res/desktop-icon.png \
    -d ../res/densify.desktop \
    --plugin conda \
    --custom-apprun ../src/AppRun.sh \
    --output appimage

# Prepare Script to Sign
cp ../src/signAppImage.sh .