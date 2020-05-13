# ARM Cortex-M build system.

# Include targeted architecture.
include $(BUILD)/arch/$(TARGET).mk

# If no LDSCRIPT specified, fallback on target name.
LDSCRIPT ?= $(TARGET).ld

# Append built-in linker scripts path.
LDPATHS += -L$(BUILD)/ld
