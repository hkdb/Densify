#! /bin/bash

APPDIR=`dirname $0`
export PATH="$PATH":"${APPDIR}"/usr/bin
export LD_LIBRARY_PATH="${APPDIR}"/usr/lib
export LD_PRELOAD="${APPDIR}"/usr/lib/libffi.so.8

${APPDIR}/usr/conda/bin/python ${APPDIR}/opt/Densify/densify
