LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	prop_init.c

LOCAL_SHARED_LIBRARIES := \
	libcutils liblog

LOCAL_MODULE := prop_init

LOCAL_MODULE_TAGS := optional

include $(BUILD_EXECUTABLE)
