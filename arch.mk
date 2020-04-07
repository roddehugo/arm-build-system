# Include targeted architecture.
include $(BUILD)/arch/$(TARGET).mk

# If no LDSCRIPT specified, fallback on target name.
ifeq ($(LDSCRIPT),)
LDSCRIPT = $(TARGET).ld
endif
