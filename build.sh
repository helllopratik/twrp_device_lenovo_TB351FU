#!/bin/bash
# OrangeFox Build Script for TB351FU
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_MAINTAINER_PATCH_VERSION="1"
export LC_ALL="C"

# Clean previous build
# make clean

# Set up environment
source build/envsetup.sh
lunch twrp_tb351fu-ap2a-eng

# Build recovery image
mka recoveryimage -j$(nproc)

echo "Build finished. Check out/target/product/tb351fu/recovery.img"

