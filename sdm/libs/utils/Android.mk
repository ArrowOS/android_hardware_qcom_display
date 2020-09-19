LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
include $(LOCAL_PATH)/../../../common.mk

LOCAL_MODULE                  := libsdmutils
LOCAL_VENDOR_MODULE           := true
LOCAL_MODULE_TAGS             := optional
LOCAL_C_INCLUDES              := $(common_includes)
LOCAL_HEADER_LIBRARIES        := display_headers
LOCAL_CFLAGS                  := -DLOG_TAG=\"SDM\" $(common_flags)
LOCAL_SRC_FILES               := debug.cpp \
                                 rect.cpp \
                                 sys.cpp \
                                 formats.cpp \
                                 utils.cpp

include $(BUILD_SHARED_LIBRARY)

SDM_HEADER_PATH := ../../include
include $(CLEAR_VARS)
LOCAL_VENDOR_MODULE           := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(SDM_HEADER_PATH)/utils

include $(BUILD_COPY_HEADERS)
