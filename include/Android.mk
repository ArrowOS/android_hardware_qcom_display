LOCAL_PATH:= $(call my-dir)
include $(LOCAL_PATH)/../common.mk
include $(CLEAR_VARS)

# Legacy header copy. This is deprecated.
# Modules using these headers should shift to using
# LOCAL_HEADER_LIBRARIES := display_headers
LOCAL_VENDOR_MODULE           := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH) \
                               $(LOCAL_PATH)/../libqdutils
                               $(LOCAL_PATH)/../libqservice

include $(BUILD_COPY_HEADERS)
