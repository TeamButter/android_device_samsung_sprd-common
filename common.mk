#
# Copyright (C) 2016 The CyanogenMod Project
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

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, hardware/samsung/sprd/sprd.mk)

LOCAL_PATH := device/samsung/sprd-common

# Audio
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default \
	libtinyalsa \
	tinymix

# WiFi
PRODUCT_PACKAGES += \
	libnetcmdiface \
	dhcpcd.conf \
	wpa_supplicant \
	hostapd

# Device props
PRODUCT_PROPERTY_OVERRIDES := \
	keyguard.no_require_sim=true \
	ro.com.android.dataroaming=false \
	persist.sys.sprd.modemreset=0

# Board-Pecific
PRODUCT_PACKAGES += \
    lights.sc8810
    	
# Compat
PRODUCT_PACKAGES += \
    libril_shim \
	libstlport
	
# Media
PRODUCT_PACKAGES += \
	libstagefrighthw
	
	
# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

# Charger
PRODUCT_PACKAGES += \
	charger

# Permissions
PERMISSION_XML_FILES := \
	frameworks/native/data/etc/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.location.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.xml \
	frameworks/native/data/etc/android.software.sip.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml \

PRODUCT_COPY_FILES += \
	$(foreach f,$(PERMISSION_XML_FILES),$(f):system/etc/permissions/$(notdir $(f)))

# Filesystem management tools
PRODUCT_PACKAGES += \
	setup_fs \

# Misc packages
PRODUCT_PACKAGES += \
	com.android.future.usb.accessory \
    
# Samsung Service Mode
PRODUCT_PACKAGES += \
	SamsungServiceMode


# Web
PRODUCT_PACKAGES += \
    libskia_legacy
    
# Camera
PRODUCT_PACKAGES += \
    Snap \
    Gallery2 \
    camera.sc8810 \
    libmemoryheapion
    
# WiFi    
$(call inherit-product, hardware/broadcom/wlan/bcmdhd/config/config-bcm.mk)
