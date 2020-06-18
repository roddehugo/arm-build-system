# ARM Cortex-M build system.

SPECS := nano.specs # Use newlib nano for code size reduction.

# Cortex-M3 arch flags.
ARCH_FLAGS += -mthumb # Use Thumb instruction sets.
ARCH_FLAGS += -mcpu=cortex-m3 # Use Cortex-M3 processor.
ARCH_FLAGS += -mfloat-abi=soft # Use soft floating-point ABI.
ARCH_FLAGS += --specs=$(SPECS)

# Cortex-M3 arch definitions.
ARCH_DEFS += $(call ifdefined,FAMILY,-D$(call toupper,$(FAMILY)))

# Cortex-M3 arch libraries.
ARCH_LIBS += -nostartfiles # No standard system startup files.
ARCH_LIBS += --specs=$(SPECS)
