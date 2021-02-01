LOCAL_DIR := $(call current-dir)

LIBOPENCM3_DIR := $(LOCAL_DIR)/../../libopencm3

IRQ_DEFN_FILES  := $(LIBOPENCM3_DIR)/include/libopencm3/stm32/f1/irq.json
NVIC_H := $(IRQ_DEFN_FILES:%/irq.json=%/nvic.h)
VECTOR_NVIC_C := $(IRQ_DEFN_FILES:./include/libopencm3/%/irq.json=./lib/%/vector_nvic.c)
IRQHANDLERS_H := $(IRQ_DEFN_FILES:./include/libopencm3/%/irq.json=./include/libopencmsis/%/irqhandlers.h)
IRQ_GENERATED_FILES = $(NVIC_H) $(VECTOR_NVIC_C) $(IRQHANDLERS_H)

$(LIBOPENCM3_DIR)/include/libopencm3/%/nvic.h $(LIBOPENCM3_DIR)/lib/%/vector_nvic.c $(LIBOPENCM3_DIR)/include/libopencmsis/%/irqhandlers.h: INTERNAL_LIBOPENCM3_DIR := $(LIBOPENCM3_DIR)
$(LIBOPENCM3_DIR)/include/libopencm3/%/nvic.h $(LIBOPENCM3_DIR)/lib/%/vector_nvic.c $(LIBOPENCM3_DIR)/include/libopencmsis/%/irqhandlers.h: $(LIBOPENCM3_DIR)/include/libopencm3/%/irq.json
	@cd $(LOCAL_DIR)/../../libopencm3/; ./scripts/irq2nvic_h $(patsubst $(INTERNAL_LIBOPENCM3_DIR)/%, ./%, $<)

include $(CLEAR_VARS)

LOCAL_CROSS_COMPILE := arm-none-eabi-
CC := gcc
CXX := g++

LOCAL_NAME := opencm3_stm32f1

LOCAL_PREREQUISITES := $(IRQ_GENERATED_FILES)

LOCAL_CFLAGS := \
    -mcpu=cortex-m3 \
    -mfloat-abi=soft \
    -mthumb \
    -Os \
    -Wall \
    -Wextra \
    -Wimplicit-function-declaration \
    -Wredundant-decls \
    -Wmissing-prototypes \
    -Wstrict-prototypes \
    -Wundef \
    -Wshadow \
    -fno-common \
    -Wstrict-prototypes \
    -ffunction-sections \
    -fdata-sections \
    -DSTM32F1 \
    -I$(LOCAL_DIR)/../../libopencm3/include

LOCAL_SRC := \
    $(LOCAL_DIR)/../../libopencm3/lib/cm3/vector.c \
    $(LOCAL_DIR)/../../libopencm3/lib/cm3/systick.c \
    $(LOCAL_DIR)/../../libopencm3/lib/cm3/scb.c \
    $(LOCAL_DIR)/../../libopencm3/lib/cm3/nvic.c \
    $(LOCAL_DIR)/../../libopencm3/lib/cm3/assert.c \
    $(LOCAL_DIR)/../../libopencm3/lib/cm3/sync.c \
    $(LOCAL_DIR)/../../libopencm3/lib/cm3/dwt.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/adc_common_v1.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/crc_common_all.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/dac_common_all.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/desig_common_all.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/desig_common_v1.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/dma_common_l1f013.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/exti_common_all.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/flash_common_all.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/flash_common_f.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/flash_common_f01.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/gpio_common_all.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/i2c_common_v1.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/iwdg_common_all.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/pwr_common_v1.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/rcc_common_all.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/spi_common_all.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/spi_common_v1.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/timer_common_all.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/usart_common_all.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/usart_common_f124.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/common/st_usbfs_core.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/can.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/st_usbfs_v1.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/f1/adc.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/f1/flash.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/f1/gpio.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/f1/rcc.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/f1/rtc.c \
    $(LOCAL_DIR)/../../libopencm3/lib/stm32/f1/timer.c \
    $(LOCAL_DIR)/../../libopencm3/lib/ethernet/mac.c \
    $(LOCAL_DIR)/../../libopencm3/lib/ethernet/mac_stm32fxx7.c \
    $(LOCAL_DIR)/../../libopencm3/lib/ethernet/phy.c \
    $(LOCAL_DIR)/../../libopencm3/lib/ethernet/phy_ksz80x1.c \
    $(LOCAL_DIR)/../../libopencm3/lib/usb/usb.c \
    $(LOCAL_DIR)/../../libopencm3/lib/usb/usb_control.c \
    $(LOCAL_DIR)/../../libopencm3/lib/usb/usb_standard.c \
    $(LOCAL_DIR)/../../libopencm3/lib/usb/usb_msc.c \
    $(LOCAL_DIR)/../../libopencm3/lib/usb/usb_hid.c \
    $(LOCAL_DIR)/../../libopencm3/lib/usb/usb_dwc_common.c \
    $(LOCAL_DIR)/../../libopencm3/lib/usb/usb_f107.c
    
LOCAL_EXPORTED_DIRS := \
    $(LOCAL_DIR)/../../libopencm3/include

LOCAL_ARFLAGS := -rcs
include $(BUILD_STATIC_LIB)

