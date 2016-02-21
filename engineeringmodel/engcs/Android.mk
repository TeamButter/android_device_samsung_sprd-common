#LIBENGCLIENT
LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_PRELINK_MODULE := false

LOCAL_LDLIBS        += -Idl

#LOCAL_CFLAGS += -DENG_API_LOG

LOCAL_SHARED_LIBRARIES := libcutils

LOCAL_C_INCLUDES  += engopt.h \
					engapi.h

LOCAL_SRC_FILES     :=   engopt.c \
		       	          engapi.c \
       				   eng_attok.c \
	      				   engparcel.c \
	      				   engclient.c \
				  eng_common.c \
		       	          eng_modemclient.c \
                          engphasecheck.c \
		       	          eng_appclient.c

LOCAL_MODULE:= libengclient
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)


#LIBENG_WIFI_PTEST

