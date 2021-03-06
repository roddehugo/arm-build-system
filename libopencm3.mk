# libopencm3 - Open source ARM Cortex-M microcontroller library.

# Automatically lookup for libopencm3.
ifeq ($(OPENCM3_DIR),)
# Where we search for the library.
OPENCM3_PATHS := $(BASE)/libopencm3 $(BASE)/lib/libopencm3
OPENCM3_DIR := $(wildcard $(OPENCM3_PATHS:=/locm3.sublime-project))
OPENCM3_DIR := $(patsubst %/,%,$(firstword $(dir $(OPENCM3_DIR))))
endif

# Only if the library is found. It is optional after all.
ifneq ($(OPENCM3_DIR),)
# Base the library name upon targeted board family.
LIBNAME ?= opencm3_$(FAMILY)
LIBDEPS += $(OPENCM3_DIR)/lib/lib$(LIBNAME).a

INCLUDES += -I$(OPENCM3_DIR)/include
LDFLAGS += -L$(OPENCM3_DIR)/lib
LDLIBS += -l$(LIBNAME)
endif

$(OPENCM3_DIR)/lib/lib$(LIBNAME).a:
	$(warning $(LIBNAME).a not found, attempting to rebuild in $(OPENCM3_DIR))
	$(Q)$(MAKE) -C $(OPENCM3_DIR)
