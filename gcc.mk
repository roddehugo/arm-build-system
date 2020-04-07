PREFIX ?= arm-none-eabi-

CC := $(PREFIX)gcc
CXX := $(PREFIX)g++
LD := $(PREFIX)gcc
AR := $(PREFIX)ar
AS := $(PREFIX)as
NM := $(PREFIX)nm
GDB := $(PREFIX)gdb
SIZE := $(PREFIX)size
OBJCOPY := $(PREFIX)objcopy
OBJDUMP := $(PREFIX)objdump
