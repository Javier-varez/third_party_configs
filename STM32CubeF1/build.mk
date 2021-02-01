LOCAL_DIR := $(call current-dir)

include $(CLEAR_VARS)

LOCAL_CROSS_COMPILE := arm-none-eabi-
CC := gcc
CXX := g++

LOCAL_NAME := stm32cubef1

LOCAL_CFLAGS := \
    -Os \
    -g3 \
    -Wall \
    -Werror \
    -ffunction-sections \
    -fdata-sections \
    -mcpu=cortex-m3 \
    -mfloat-abi=soft \
    -mthumb \
    -DSTM32F103xB \
    -I$(LOCAL_DIR)/include \
    -I$(LOCAL_DIR)/../../STM32CubeF1/Drivers/CMSIS/Core/Include \
    -I$(LOCAL_DIR)/../../STM32CubeF1/Drivers/CMSIS/Device/ST/STM32F1xx/Include \
    -I$(LOCAL_DIR)/../../STM32CubeF1/Drivers/STM32F1xx_HAL_Driver/Inc

LOCAL_ARFLAGS := -rcs

LOCAL_SRC := \
    $(filter-out %_template.c, $(wildcard $(LOCAL_DIR)/../../STM32CubeF1/Drivers/STM32F1xx_HAL_Driver/Src/*.c))

LOCAL_EXPORTED_DIRS := \
    $(LOCAL_DIR)/include \
    $(LOCAL_DIR)/../../STM32CubeF1/Drivers/STM32F1xx_HAL_Driver/Inc \
    $(LOCAL_DIR)/../../STM32CubeF1/Drivers/CMSIS/Device/ST/STM32F1xx/Include \
    $(LOCAL_DIR)/../../STM32CubeF1/Drivers/CMSIS/Core/Include

include $(BUILD_STATIC_LIB)

