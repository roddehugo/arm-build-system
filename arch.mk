# ARM Cortex-M build system.

# Include targeted architecture.
include $(BUILD)/arch/$(TARGET).mk

# If no LDSCRIPT specified, fallback on target name.
LDSCRIPT ?= $(BASE)/ld/$(TARGET).ld
