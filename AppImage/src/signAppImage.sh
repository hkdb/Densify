#!/bin/bash

# Determine Verison of Application
raw=$(awk '/VERSION:/{getline; print}' AppDir/opt/Densify/densify)
version=${raw:4}

# Determine Today's Date
date=$(date +"%Y-%m-%d")

# Install MentaInfo
mkdir -p ./AppDir/usr/share/metainfo
install -D -m 644 ../src/io.3df.osi.densify.metainfo.xml ./AppDir/usr/share/metainfo/

# Insert Version to MetaInfo
vnum=${version:1}
line="/<releases>/a\      <release version=\"$vnum\" date=\"$date\">"
sed -i "$line" ./AppDir/usr/share/metainfo/io.3df.osi.densify.metainfo.xml

# Sign AppImage
./appimagetool-x86_64.AppImage AppDir --sign --sign-key 205CCAC6515402D4B1F83A3622984F9A0EA52036

# Deploy
./linuxdeploy-x86_64.AppImage \
   --appdir AppDir \
    -i ../res/desktop-icon.png \
    -d ../res/densify.desktop \
    --plugin conda \
    --custom-apprun ../src/AppRun.sh \
    --output appimage

mv Densify-x86_64.AppImage Densify-"$version"-x86_64.AppImage