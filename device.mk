#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/xiaomi/stone
# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Configure core_64_bit_only.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Configure gsi_keys.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Configure Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Configure SDCard replacement functionality
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Configure twrp
$(call inherit-product, vendor/twrp/config/common.mk)

# Требуеться для firstage -------------------------------#
PRODUCT_PACKAGES += linker.vendor_ramdisk                #
PRODUCT_PACKAGES += linker_hwasan64.vendor_ramdisk       #
PRODUCT_PACKAGES += resize2fs.vendor_ramdisk             #
PRODUCT_PACKAGES += resize.f2fs.vendor_ramdisk           #
PRODUCT_PACKAGES += dump.f2fs.vendor_ramdisk             #
PRODUCT_PACKAGES += defrag.f2fs.vendor_ramdisk           #
PRODUCT_PACKAGES += fsck.vendor_ramdisk                  #
PRODUCT_PACKAGES += tune2fs.vendor_ramdisk               #
PRODUCT_PACKAGES += fstab.zuma.vendor_ramdisk            #
PRODUCT_PACKAGES += fstab.zuma-fips.vendor_ramdisk       #
PRODUCT_PACKAGES += e2fsck.vendor_ramdisk                #
# Требуеться для firstage -------------------------------#


# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script
    
PRODUCT_PACKAGES += \
    vndservicemanager
    
PRODUCT_PACKAGES += \
    vndservice
    
# Hindl

PRODUCT_PACKAGES += \
    libhidltransport.vendor \
    libhwbinder.vendor

# Bootctrl
PRODUCT_PACKAGES += \
    bootctrl.stone.recovery \
    android.hardware.boot@1.1-impl-qti.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# SHIPPING API
PRODUCT_SHIPPING_API_LEVEL := 30

# VNDK API
PRODUCT_TARGET_VNDK_VERSION := 31

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Kernel
TWRP_REQUIRED_MODULES += \
	miui_prebuilt

# Twrp Decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Soong Namespaces : Qcom commonsys Display
PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/commonsys-intf/display \
    $(DEVICE_PATH) 

# Misc.
TARGET_RECOVERY_DEVICE_MODULES += \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0 \
    libdisplayconfig.qti 
    
    
# TWRP haptic feedback 

TW_SUPPORT_INPUT_AIDL_HAPTICS := true


RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so