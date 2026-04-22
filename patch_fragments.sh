#!/bin/bash
# TB351FU Fragment Patcher & Hijacker - ROBUST VERSION
# This script automates the Fragment 0 "Physical Hijack" strategy.

set -e

# 1. Detect Project Root
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
TOP_DIR=$(cd "$SCRIPT_DIR/../../../" && pwd)
DEV_TREE="device/lenovo/tb351fu"

# 2. Define Absolute Paths
MAGISKBOOT="$TOP_DIR/vendor/recovery/tools/magiskboot"
STOCK_IMG="/media/hellopratik/HDD/LINUX APPS/tablet/new_updated/TB351FU_ROW_OPEN_USER_M15125.2_A16_ZUI_17.5.10.073_ST_260213/gemini_source/firmware/vendor_boot.img"
WORK_DIR="$TOP_DIR/work_patch"
BLOBS_DIR="$TOP_DIR/$DEV_TREE/prebuilt"

echo "=== TB351FU Fragment Hijack Tool ==="
echo "Project Root: $TOP_DIR"
echo "Stock Image: $STOCK_IMG"

# Check dependencies
if [ ! -f "$MAGISKBOOT" ]; then
    echo "ERROR: magiskboot not found at $MAGISKBOOT"
    exit 1
fi

if [ ! -f "$STOCK_IMG" ]; then
    echo "ERROR: stock image not found at $STOCK_IMG"
    exit 1
fi

mkdir -p "$WORK_DIR"
cd "$WORK_DIR"
cp "$STOCK_IMG" ./vendor_boot.img

# 1. Unpack Stock
echo "[1/4] Unpacking stock image..."
"$MAGISKBOOT" unpack vendor_boot.img

# 2. Patch Fragment 0 (Platform)
echo "[2/4] Patching Fragment 0 (Platform)..."
mkdir -p r0
cd r0
cpio -id < ../vendor_ramdisk/ramdisk.cpio

# Apply Physical VINTF Hijack
mkdir -p system/etc/vintf
cat <<EOF > system/etc/vintf/manifest.xml
<manifest version="8.0" type="device">
    <hal format="aidl">
        <name>android.hardware.health</name>
        <version>4</version>
        <fqname>IHealth/default</fqname>
    </hal>
    <hal format="aidl">
        <name>vendor.lenovo.hardware.touchscreen</name>
        <version>2</version>
        <fqname>ITouchscreen/default</fqname>
    </hal>
</manifest>
EOF

# Inject Blobs and IDC
mkdir -p system/usr/idc
echo -e "touch.deviceType = touchScreen\ntouch.orientationAware = 1" > system/usr/idc/NVTCapacitiveTouchScreen.idc
mkdir -p vendor/bin/hw
mkdir -p vendor/lib64
cp -f "$BLOBS_DIR/vendor.lenovo.hardware.touchscreen-service" vendor/bin/hw/
cp -f "$BLOBS_DIR/vendor.lenovo.hardware.touchscreen-V2-ndk.so" vendor/lib64/
chmod +x vendor/bin/hw/vendor.lenovo.hardware.touchscreen-service

# Force start services in init.rc
# We use a more precise sed to avoid double entries
if ! grep -q "touchscreen_hal_service" system/etc/init/hw/init.rc; then
    sed -i "/on init/a \    start ueventd\n    start servicemanager\n    start hwservicemanager\n    start touchscreen_hal_service" system/etc/init/hw/init.rc
fi

# Simplify Fstab
sed -i "s|/dev/block/by-name/userdata.*|/dev/block/by-name/userdata /data f2fs noatime,nosuid,nodev,discard wait,check,formattable,quota|g" first_stage_ramdisk/fstab.mt8781

# Repack R0
find . | cpio -o -H newc > ../vendor_ramdisk/ramdisk.cpio
cd ..

# 3. Patch Fragment 1 (Recovery)
echo "[3/4] Patching Fragment 1 (Recovery)..."
# Try to find the freshly built recovery ramdisk
REC_RAMDISK_SRC="$TOP_DIR/out/target/product/tb351fu/ramdisk-recovery.lz4"
if [ -f "$REC_RAMDISK_SRC" ]; then
    echo "Found built recovery ramdisk at $REC_RAMDISK_SRC"
    cp -f "$REC_RAMDISK_SRC" vendor_ramdisk/recovery.cpio
else
    echo "WARNING: No freshly built recovery ramdisk found. Using existing fragment 1."
fi

# 4. Final Repack
echo "[4/4] Repacking final image..."
"$MAGISKBOOT" repack vendor_boot.img OrangeFox-TB351FU-HIJACKED.img
cp OrangeFox-TB351FU-HIJACKED.img "$TOP_DIR/OrangeFox-TB351FU-HIJACKED.img"

echo "=== SUCCESS! ==="
echo "Final Image: $TOP_DIR/OrangeFox-TB351FU-HIJACKED.img"
