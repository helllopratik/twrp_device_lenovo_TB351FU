#
# BoardConfig.mk - Lenovo Tab Plus (TB351FU)
# OrangeFox 14.1 (Android 16) - RECOVERY CALIBRATION
#

DEVICE_PATH := device/lenovo/tb351fu

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Platform
TARGET_BOARD_PLATFORM := mt6789
TARGET_BOOTLOADER_BOARD_NAME := t808aa
BOARD_HAS_MTK_HARDWARE := true
BOARD_USES_MTK_COMMON := true

# Properties
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.hardware=mt8781 \
    ro.board.platform=mt6789 \
    ro.boot.dynamic_partitions=true \
    ro.boot.selinux=permissive \
    ro.secure=1 \
    ro.debuggable=0 \
    ro.adb.secure=1 \
    ro.orangefox.no_apex_mount=1 \
    ro.crypto.state=unencrypted \
    ro.crypto.type=none \
    tw_include_crypto=false \
    persist.sys.usb.config=mtp,adb \
    sys.usb.config=mtp,adb \
    tw_brightness_path="/sys/class/leds/lcd-backlight/brightness" \
    tw_max_brightness=2047 \
    tw_default_brightness=1200 \
    ro.orangefox.boot=1

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_VNDK_VERSION := current

# Boot Header
BOARD_BOOT_HEADER_VERSION := 4
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_KERNEL_PAGESIZE := 4096

# Kernel Offsets & Name
TARGET_NO_KERNEL := false
BOARD_KERNEL_IMAGE_NAME := kernel
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_OFFSET := 0x00000000
BOARD_RAMDISK_OFFSET := 0x26f00000
BOARD_TAGS_OFFSET := 0x07c80000
BOARD_KERNEL_TAGS_OFFSET := 0x07c80000
BOARD_DTB_OFFSET := 0x07c80000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 bootconfig androidboot.selinux=permissive
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt
BOARD_PREBUILT_DTBIMAGE := $(DEVICE_PATH)/prebuilt/dtb.dtb

# Bootconfig
BOARD_BOOTCONFIG := kernel.rcu_nocbs=all kernel.rcutree.enable_rcu_lazy=1 kernel.rcupdate.rcu_cpu_stall_cputime=1 androidboot.selinux=permissive

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_HAS_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := false
BOARD_USES_VENDOR_BOOTIMAGE := true
BOARD_USES_METADATA_PARTITION := true

# Path
BOARD_BOOTDEVICE_PATH := 11270000.ufshci

# Dynamic Partitions
BOARD_SUPPORTS_DYNAMIC_PARTITIONS := true
BOARD_SUPER_PARTITION_SIZE := 9663676416
BOARD_SUPER_PARTITION_GROUPS := lenovo_dynamic_partitions
BOARD_LENOVO_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product vendor_dlkm odm_dlkm system_dlkm
BOARD_LENOVO_DYNAMIC_PARTITIONS_SIZE := 4819255296

# Graphics
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
RECOVERY_GRAPHICS_FORCE_USE_LINELENGTH := true
TW_THEME := portrait_hdpi
TARGET_SCREEN_WIDTH := 1200
TARGET_SCREEN_HEIGHT := 2000

# OrangeFox / TWRP Specifics
FOX_RECOVERY_INSTALL_DIR := /system/bin
FOX_RECOVERY_SYSTEM_PART := /dev/block/mapper/system
FOX_RECOVERY_VENDOR_PART := /dev/block/mapper/vendor
TW_DEVICE_VERSION := V54
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
TW_HAS_MTP := true

# Fragment 0 / Platform Support
BOARD_RAMDISK_FRAGMENT_0_NAME := platform
BOARD_RAMDISK_FRAGMENT_0_TYPE := platform
BOARD_RAMDISK_FRAGMENT_0_FMT := lz4_legacy

# Brightness
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1200

# Storage
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_DEFAULT_EXTERNAL_STORAGE := true
RECOVERY_SDCARD_ON_DATA := true

# Crypto & Decryption (Android 16 / FBE v2)
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2
BOARD_USES_METADATA_PARTITION := true

# Module Loading
TW_LOAD_VENDOR_BOOT_MODULES := true

# Fixes
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_ERRORS := true
ADDITIONAL_DEFAULT_PROPERTIES += persist.sys.disable_rescue=true
BOARD_RAMDISK_USE_LZ4 := true

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/public
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/private

# MTK Specific
BOARD_HAS_MTK_HARDWARE := true
BOARD_USES_MTK_COMMON := true
BOARD_MTK_ENABLE_GENERIC_HAL := true

# OrangeFox Additions
FOX_MAINTAINER_PATCH_VERSION := 1
TW_DEVICE_VERSION := V54-FINAL
FOX_VANILLA := 1
FOX_ENABLE_APP_MANAGER := 1
FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER := 1
FOX_USE_BASH_SHELL := 1
FOX_USE_NANO_EDITOR := 1
FOX_USE_TAR_BINARY := 1
FOX_USE_SED_BINARY := 1
FOX_USE_XZ_UTILS := 1
FOX_REPLACE_BUSYBOX_UTILS := 1
