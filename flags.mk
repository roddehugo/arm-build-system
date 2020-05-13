# ARM Cortex-M build system.

# Warning flags.
WARN_FLAGS += -Wall # Enable all warnings.
WARN_FLAGS += -Wextra # Enable extra warnings.
WARN_FLAGS += -Werror # Turn warnings into errors.
WARN_FLAGS += -Wshadow # Warn for any global shadowing.
WARN_FLAGS += -Wundef # Warn if an undefined identifier is evaluated.
WARN_FLAGS += -Wno-unused-parameter # Do not warn for unused parameter.

# Optimization flags.
OPTI_FLAGS += -fno-common # Place uninitialized global variables in bss.
OPTI_FLAGS += -ffunction-sections # Place each function into its own section.
OPTI_FLAGS += -fdata-sections # Place each data into its own section.

# Assembler flags.
ASFLAGS += $(DEBUG)
ASFLAGS += $(ARCH_FLAGS)
ASFLAGS += -x assembler-with-cpp

# C flags.
CFLAGS += $(CSTD) $(OPT) $(DEBUG)
CFLAGS += $(ARCH_FLAGS) $(OPTI_FLAGS) $(WARN_FLAGS)
CFLAGS += -Wmissing-prototypes # Warn functions defined without prototype.
CFLAGS += -Wstrict-prototypes # Warn functions defined without argument types.

# C++ flags.
CXXFLAGS += $(CXXSTD) $(OPT) $(DEBUG)
CXXFLAGS += $(ARCH_FLAGS) $(OPTI_FLAGS) $(WARN_FLAGS)
CXXFLAGS += -Weffc++ # Warn about violations of the Scott Meyers's guidelines.
CXXFLAGS += -fno-exceptions # Disable C++ exceptions. Most of the std namespace is off-limits, including STL containers, except <algorithm>, which is mostly OK to use.
CXXFLAGS += -fno-rtti # Disable generation of information about every class with virtual functions for use by the C++ run-time type identification features.
CXXFLAGS += -fno-threadsafe-statics # Do not emit the extra code to use the routines specified in the C++ ABI for thread-safe initialization of local statics.

# Preprocessor flags.
DEFS += $(ARCH_DEFS)
CPPFLAGS += $(DEFS)
CPPFLAGS += -MP # Emit dummy dependency rules.
CPPFLAGS += -MMD # List only user header files.

# Linker flags.
LDFLAGS += $(DEBUG)
LDFLAGS += $(ARCH_FLAGS)
LDFLAGS += -T$(LDSCRIPT) $(LDPATHS)
LDFLAGS += -nostartfiles # No standard system startup files.
LDFLAGS += -Wl,--gc-sections # Enable garbage collection of unused input sections.
LDFLAGS += -Wl,--build-id # Enable build ID issuance to .note.gnu.build-id section.

# Map flags.
MAPFLAGS += -Wl,-Map=$(*).map # Output some information about the link.
MAPFLAGS += -Wl,--cref # Output a cross reference table.

# Debug linking output.
ifeq ($(V),99)
LDFLAGS += -Wl,--print-gc-sections
endif
