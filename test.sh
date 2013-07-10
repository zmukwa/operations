#!/usr/bin/env bash

# build directory
BUILD_DIR="${WORKSPACE}/build/release"

if [ ! -d "${BUILD_DIR}" ]; then
    echo ">>> Could not find a release build to apply tests."
else
    cd "${BUILD_DIR}"
    make test
fi
