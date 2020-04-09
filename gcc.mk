# ARM Cortex-M build system.

# User can redefine path to arm-none-eabi.
PREFIX ?= arm-none-eabi-

# ARM GNU Compiler programs.
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
