#! /bin/bash

APPDIR=`dirname $0`
export PATH="$PATH":"${APPDIR}"/usr/bin

${APPDIR}/usr/bin/python3 ${APPDIR}/opt/Densify/densify
