# Where our Black Magic Probe is attached.
BMP_PORT ?= $(firstword $(wildcard /dev/cu.usbmodem*1))
BMP_PROG = $(GDB) --silent -ex 'target extended-remote $(BMP_PORT)'
BMP_FLASH = $(BMP_PROG) -x $(BUILD)/scripts/bmp-flash.scr
BMP_DEBUG = $(BMP_PROG) -x $(BUILD)/scripts/bmp-debug.scr
