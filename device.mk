#
# Copyright (C) 2023-2024
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

# -----------------------------------------------------------------------------
# Base inherit: Qualcomm common, storage, dalvik, A/B with vendor_ramdisk
# -----------------------------------------------------------------------------


# Configure twrp
$(call inherit-product, vendor/twrp/config/common.mk)

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    otapreopt_script

# Emulated storage (no sdcardfs)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)


# A/B (virtual A/B, vendor ramdisk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# -----------------------------------------------------------------------------
# Display / screen
# -----------------------------------------------------------------------------

TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# -----------------------------------------------------------------------------
# Dynamic partitions
# -----------------------------------------------------------------------------

PRODUCT_USE_DYNAMIC_PARTITIONS := true

# -----------------------------------------------------------------------------
# Fastbootd / bootctrl / OTA engine (useful for modern recoveries incl. TWRP)
# -----------------------------------------------------------------------------

PRODUCT_PACKAGES += \
    android.hardware.boot-service.qti \
    android.hardware.boot-service.qti.recovery \
    fastbootd

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# -----------------------------------------------------------------------------
# Health (battery) in recovery
# -----------------------------------------------------------------------------

PRODUCT_PACKAGES += \
    android.hardware.health-service.qti \
    android.hardware.health-service.qti_recovery

# -----------------------------------------------------------------------------
# Device-specific init / libinit
# -----------------------------------------------------------------------------

# Custom recovery init for this device
PRODUCT_PACKAGES += \
    init_xiaomi_stone.recovery

# libinit config (for vendor init lib)
$(call soong_config_set,libinit,vendor_init_lib,//$(LOCAL_PATH):init_xiaomi_stone)

# -----------------------------------------------------------------------------
# Rootdir / fstab for first stage mount (critical for TWRP/any recovery)
# -----------------------------------------------------------------------------

PRODUCT_PACKAGES += \
    charger_fstab.qti \
    fstab.default \
    init.qcom.rc \
    init.qti.display_boot.rc \
    init.qti.kernel.rc \
    init.recovery.qcom.rc \
    init.target.rc \
    ueventd.qcom.rc

# Ensure fstab is present in both recovery and vendor_ramdisk first_stage_ramdisk

# -----------------------------------------------------------------------------
# Shipping API level
# -----------------------------------------------------------------------------

PRODUCT_SHIPPING_API_LEVEL := 31

# -----------------------------------------------------------------------------
# Soong namespaces
# -----------------------------------------------------------------------------

PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/xiaomi \
    hardware/qcom-caf/common/libqti-perfd-client \
    vendor/qcom/opensource/usb/etc

# -----------------------------------------------------------------------------
# Inherit vendor blobs
# -----------------------------------------------------------------------------

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so    
    