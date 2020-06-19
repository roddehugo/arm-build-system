# ARM Cortex-M build system.

# Include targeted architecture.
include $(BUILD)/arch/$(TARGET).mk

# If no LDSCRIPT specified, fallback on target name.
LDSCRIPT_PATH := $(BUILD)/ld
LDSCRIPT ?= $(LDSCRIPT_PATH)/$(TARGET).ld

# Append built-in linker scripts path.
LDPATHS += -L$(LDSCRIPT_PATH)

# Append ARCH definitions and flags.
DEFS += $(ARCH_DEFS)
CFLAGS += $(ARCH_FLAGS)
LDLIBS += $(ARCH_LIBS)
LDFLAGS += -T$(LDSCRIPT) $(LDPATHS) $(ARCH_FLAGS)
