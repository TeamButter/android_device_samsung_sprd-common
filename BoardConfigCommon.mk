# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# Board
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform
COMMON_GLOBAL_CFLAGS += -DSPRD_HARDWARE

# UMS
BOARD_UMS_LUNFILE := "/sys/class/android_usb/android0/f_mass_storage/lun/file"
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/dwc_otg.0/gadget/lun0/file"

# Graphics
USE_OPENGL_RENDERER := true
BOARD_EGL_NEEDS_FNW := true

# Camera
USE_CAMERA_STUB := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUEDROID_VENDOR_CONF := device/samsung/sprd-common/bluetooth/libbt_vndcfg.txt


# Healthd
BOARD_HAL_STATIC_LIBRARIES := libhealthd.sprd

# RIL
BOARD_RIL_CLASS := ../../../device/samsung/sprd-common/ril/
BOARD_MOBILEDATA_INTERFACE_NAME := "rmnet0"

# Audio
BOARD_USES_TINYALSA_AUDIO := true


# HWComposer
USE_SPRD_HWCOMPOSER := true

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGING_MODE_BOOTING_LPM := /sys/class/power_supply/battery/batt_lp_charging


# CMHW
BOARD_HARDWARE_CLASS := device/samsung/sprd-common/cmhw/

# SELinux
BOARD_SEPOLICY_DIRS += \
    device/samsung/sprd-common/sepolicy

BOARD_SEPOLICY_UNION += \
    file_contexts
