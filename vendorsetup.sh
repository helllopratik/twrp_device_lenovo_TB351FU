#!/bin/bash
# Automatically clean up the problematic root/vendor directory before each build
rm -rf out/target/product/tb351fu/root/vendor
rm -rf out/target/product/tb351fu/recovery/root/vendor

# Path to the prebuilt stock ramdisk and lz4 tool
STOCK_RAMDISK_LZ4="/home/hellopratik/Desktop/new_updated/TB351FU_ROW_OPEN_USER_M15125.2_A16_ZUI_17.5.10.073_ST_260213/TWRP_Build/device/lenovo/tb351fu/prebuilt/vendor_ramdisk.cpio"
LZ4="/home/hellopratik/Desktop/new_updated/TB351FU_ROW_OPEN_USER_M15125.2_A16_ZUI_17.5.10.073_ST_260213/TWRP_Build/prebuilts/misc/linux-x86/lz4/lz4"

# Forcefully copy the stock ramdisk to the target intermediate path
# This ensures vendor_ramdisk00 is the full stock ramdisk
TARGET_LZ4="out/target/product/tb351fu/obj/PACKAGING/vendor_boot_intermediates/vendor_ramdisk.cpio.lz4"
mkdir -p $(dirname "$TARGET_LZ4")
echo "Forcing stock ramdisk into $TARGET_LZ4"
cp "$STOCK_RAMDISK_LZ4" "$TARGET_LZ4"

# Also populate the directory just in case the build system checks for file existence
mkdir -p out/target/product/tb351fu/vendor_ramdisk
if [ ! -f out/target/product/tb351fu/vendor_ramdisk/init ]; then
    echo "Populating out/target/product/tb351fu/vendor_ramdisk for dependencies..."
    cd out/target/product/tb351fu/vendor_ramdisk
    $LZ4 -d < "$STOCK_RAMDISK_LZ4" | cpio -idm
    cd -
fi
