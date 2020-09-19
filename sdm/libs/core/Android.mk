LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
include $(LOCAL_PATH)/../../../common.mk

LOCAL_MODULE                  := libsdmcore
LOCAL_VENDOR_MODULE           := true
LOCAL_MODULE_TAGS             := optional
LOCAL_C_INCLUDES              := $(common_includes) $(kernel_includes)
LOCAL_HEADER_LIBRARIES        := display_headers
LOCAL_CFLAGS                  := -Wno-unused-parameter -DLOG_TAG=\"SDM\" \
                                 $(common_flags)
LOCAL_HW_INTF_PATH_1          := fb
LOCAL_SHARED_LIBRARIES        := libdl libsdmutils

ifneq ($(TARGET_IS_HEADLESS), true)
    LOCAL_CFLAGS              += -DCOMPILE_DRM -isystem external/libdrm
    LOCAL_SHARED_LIBRARIES    += libdrm libdrmutils
    LOCAL_HW_INTF_PATH_2      := drm
endif

ifeq ($(TARGET_USES_DRM_PP),true)
    LOCAL_CFLAGS              += -DPP_DRM_ENABLE
endif

LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps) $(kernel_deps)
LOCAL_SRC_FILES               := core_interface.cpp \
                                 core_impl.cpp \
                                 display_base.cpp \
                                 display_primary.cpp \
                                 display_hdmi.cpp \
                                 display_virtual.cpp \
                                 comp_manager.cpp \
                                 strategy.cpp \
                                 resource_default.cpp \
                                 color_manager.cpp \
                                 hw_events_interface.cpp \
                                 hw_info_interface.cpp \
                                 hw_interface.cpp \
                                 $(LOCAL_HW_INTF_PATH_1)/hw_info.cpp \
                                 $(LOCAL_HW_INTF_PATH_1)/hw_device.cpp \
                                 $(LOCAL_HW_INTF_PATH_1)/hw_primary.cpp \
                                 $(LOCAL_HW_INTF_PATH_1)/hw_hdmi.cpp \
                                 $(LOCAL_HW_INTF_PATH_1)/hw_virtual.cpp \
                                 $(LOCAL_HW_INTF_PATH_1)/hw_color_manager.cpp \
                                 $(LOCAL_HW_INTF_PATH_1)/hw_scale.cpp \
                                 $(LOCAL_HW_INTF_PATH_1)/hw_events.cpp

ifneq ($(TARGET_IS_HEADLESS), true)
    LOCAL_SRC_FILES           += $(LOCAL_HW_INTF_PATH_2)/hw_info_drm.cpp \
                                 $(LOCAL_HW_INTF_PATH_2)/hw_device_drm.cpp \
                                 $(LOCAL_HW_INTF_PATH_2)/hw_events_drm.cpp \
                                 $(LOCAL_HW_INTF_PATH_2)/hw_scale_drm.cpp \
                                 $(LOCAL_HW_INTF_PATH_2)/hw_color_manager_drm.cpp
endif

include $(BUILD_SHARED_LIBRARY)

SDM_HEADER_PATH := ../../include
include $(CLEAR_VARS)
LOCAL_VENDOR_MODULE           := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(SDM_HEADER_PATH)/core
include $(BUILD_COPY_HEADERS)

include $(CLEAR_VARS)
LOCAL_VENDOR_MODULE           := true
LOCAL_EXPORT_C_INCLUDE_DIRS := $(SDM_HEADER_PATH)/private
include $(BUILD_COPY_HEADERS)
