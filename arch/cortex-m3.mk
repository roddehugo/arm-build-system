# Cortex-M3 arch flags.
ARCH_FLAGS += -mthumb # Use Thumb instruction sets.
ARCH_FLAGS += -mcpu=cortex-m3 # Use Cortex-M3 processor.
ARCH_FLAGS += -mfloat-abi=soft # Use soft floating-point ABI.

# Cortex-M3 arch definitions.
ARCH_DEFS += $(call ifdefined,$(FAMILY),-D$(call toupper,$(FAMILY)))
