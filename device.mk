#
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
LOCAL_PATH := device/samsung/sprd-common

# Media
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/media/media_codecs.xml:system/etc/media_codecs.xml \
	$(LOCAL_PATH)/media/media_profiles.xml:system/etc/media_profiles.xml


#Wifi
PRODUCT_PACKAGES += \
	dhcpcd.conf \
	wpa_supplicant.conf

# Audio
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default \
	libtinyalsa \
	tinymix
    

# Camera
PRODUCT_PACKAGES += \
	Gallery2
	

# WiFi
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/prebuilt/bin/hostapd:system/bin/hostapd \
	$(LOCAL_PATH)/prebuilt/bin/wpa_supplicant:system/bin/wpa_supplicant


# Lights
PRODUCT_PACKAGES += \
	lights.sc8810

# Camera
PRODUCT_PACKAGES += \
	camera.sc8810
	
# Graphics
PRODUCT_PACKAGES += \
	gralloc.sc8810 \
	hwcomposer.sc8810 \
	libUMP
    
# Audio
PRODUCT_PACKAGES += \
	audio.primary.sc8810 \
	audio_policy.sc8810 \
	libaudiopolicy \
	libvbeffect \
	libvbpga \
	audio_vbc_eq 
	

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

# Charger
PRODUCT_PACKAGES += \
	charger \
	charger_res_images

# Permissions
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
 	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml \
 	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml

# Filesystem management tools
PRODUCT_PACKAGES += \
	setup_fs

# Misc packages
PRODUCT_PACKAGES += \
	com.android.future.usb.accessory
    
# Samsung Service Mode
PRODUCT_PACKAGES += \
	SamsungServiceMode

	
# Proper CPU Frequency scaling driver module by psych.half
PRODUCT_PACKAGES += \
	cpufreq-sc8810.ko
	
# MemoryHeapIon needed by camera and HWC
PRODUCT_PACKAGES += \
	libmemoryheapion
    
# Web
PRODUCT_PACKAGES += \
	libskia_legacy

