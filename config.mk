LOCAL_DIR := $(call current-dir)
THIRD_PARTY_CFG_DIR := $(LOCAL_DIR)

ifneq ($(wildcard $(THIRD_PARTY_CFG_DIR)/STM32CubeF1/*),)
include $(THIRD_PARTY_CFG_DIR)/configs/STM32CubeF1/build.mk
endif

ifneq ($(wildcard $(THIRD_PARTY_CFG_DIR)/libopencm3/*),)
include $(THIRD_PARTY_CFG_DIR)/configs/libopencm3/build.mk
endif

