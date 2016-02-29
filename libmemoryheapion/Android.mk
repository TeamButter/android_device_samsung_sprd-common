ifeq ($(NEEDS_MEMORYHEAPION),true)

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
#LOCAL_LDLIBS += -lpthread
LOCAL_MODULE := libmemoryheapion

    
LOCAL_SRC_FILES := MemoryHeapIon.cpp
LOCAL_SHARED_LIBRARIES += liblog libcutils libutils libbinder

include $(BUILD_SHARED_LIBRARY)

endif #NEEDS_MEMORYHEAPION

