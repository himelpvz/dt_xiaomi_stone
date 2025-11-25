#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/stone

# Base product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# 64-bit only configuration (defines ro.zygote=zygote64)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# SDCard replacement / emulated storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# TWRP common configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# ADB in vendor ramdisk
PRODUCT_PACKAGES += \
    adbd.vendor_ramdisk

# Требуеться для firstage -------------------------------#
PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    linker_hwasan64.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    resize.f2fs.vendor_ramdisk \
    dump.f2fs.vendor_ramdisk \
    defrag.f2fs.vendor_ramdisk \
    fsck.vendor_ramdisk \
    tune2fs.vendor_ramdisk \
    fstab.zuma.vendor_ramdisk \
    fstab.zuma-fips.vendor_ramdisk \
    e2fsck.vendor_ramdisk
# Требуеться для firstage -------------------------------#

# A/B postinstall configuration
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script

PRODUCT_PACKAGES += \
    vndservicemanager \
    vndservice

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport.vendor \
    libhwbinder.vendor

# Boot control
PRODUCT_PACKAGES += \
    bootctrl.stone.recovery \
    android.hardware.boot@1.1-impl-qti.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Shipping / VNDK API levels
PRODUCT_SHIPPING_API_LEVEL := 30
PRODUCT_TARGET_VNDK_VERSION := 31

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    vendor/qcom/opensource/commonsys-intf/display

PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Kernel / TWRP-required modules
TWRP_REQUIRED_MODULES += \
    miui_prebuilt

# TWRP decryption
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

# Recovery device modules
TARGET_RECOVERY_DEVICE_MODULES += \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0

# TWRP haptic feedback (AIDL input haptics)
TW_SUPPORT_INPUT_AIDL_HAPTICS := true

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so
