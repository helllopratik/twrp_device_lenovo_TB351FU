DEVICE_PATH := device/lenovo/tb351fu

# Enable A/B update support
AB_OTA_UPDATER := true

# Mandatory A/B Partition List
AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    init_boot \
    lk \
    preloader \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot

# Force Recovery Binary & UI
PRODUCT_PACKAGES += \
    recovery \
    librecovery_ui_default \
    librecovery_utils \
    otacerts

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/init.recovery.mt8781.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.mt8781.rc \
    $(DEVICE_PATH)/init.recovery.mt6789.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.mt6789.rc \
    $(DEVICE_PATH)/init.recovery.project.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.project.rc \
    $(DEVICE_PATH)/recovery/load_recovery_modules.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/load_recovery_modules.sh

# Enable EROFS support (Required for ZUI 17)
PRODUCT_FS_COMPRESSION := true
TARGET_RECOVERY_FSTYPE_MOUNT_LIST := erofs,f2fs,ext4
