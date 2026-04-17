$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, device/lenovo/tb351fu/device.mk)

PRODUCT_DEVICE := tb351fu
PRODUCT_NAME := twrp_tb351fu
PRODUCT_BRAND := Lenovo
PRODUCT_MODEL := Tab Plus
PRODUCT_MANUFACTURER := Lenovo

PRODUCT_GMS_CLIENTID_BASE := android-lenovo
