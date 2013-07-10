#!/usr/bin/env bash

if [ -z "$WORKSPACE" ]; then
    echo "Need to set WORKSPACE"
    exit 1
fi 

# build directory
BUILD_DIR="${WORKSPACE}/build/release"

if [ ! -d "${BUILD_DIR}" ]; then
    mkdir -p "${BUILD_DIR}"
    cd "${BUILD_DIR}"
    cmake -DCMAKE_BUILD_TYPE=Release "${WORKSPACE}"
else
    cd "${BUILD_DIR}"
    make rebuild_cache
fi

make -j`getconf _NPROCESSORS_ONLN`
