# ARM Cortex-M build system.

SPECS ?= nano.specs # Use newlib nano for code size reduction.

# Cortex-M4 arch flags.
ARCH_FLAGS += -mthumb # Use Thumb instruction sets.
ARCH_FLAGS += -mcpu=cortex-m4 # Use Cortex-M4 processor.
ARCH_FLAGS += -mfloat-abi=soft # Use soft floating-point ABI.
ARCH_FLAGS += -mfpu=fpv4-sp-d16 # Specify format of the floating-point values

# Cortex-M4 arch definitions.
ARCH_DEFS += $(call ifdefined,FAMILY,-D$(call toupper,$(FAMILY)))

# Cortex-M4 arch libraries.
ARCH_LIBS += -nostartfiles # No standard system startup files.
ARCH_LIBS += --specs=$(SPECS) # Specify which C library to link against.
