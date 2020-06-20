# ARM Cortex-M build system.

# C flags.
CFLAGS += -Wall # Enable all warnings.
CFLAGS += -Wextra # Enable extra warnings.
CFLAGS += -Werror # Turn warnings into errors.
CFLAGS += -Wshadow # Warn for any global shadowing.
CFLAGS += -Wundef # Warn if an undefined identifier is evaluated.
CFLAGS += -Wformat=2 # Enable '-Wformat' plus additional format checks.
CFLAGS += -Wno-unused-parameter # Do not warn for unused parameter.
CFLAGS += -Wno-unused-function # Do not warn for unused functions.
CFLAGS += -fno-common # Place uninitialized global variables in bss.
CFLAGS += -ffunction-sections # Place each function into its own section.
CFLAGS += -fdata-sections # Place each data into its own section.

# C++ flags.
CXXFLAGS += -fno-exceptions # Disable C++ exceptions.
CXXFLAGS += -fno-rtti # Disable generation run-time type identification.
CXXFLAGS += -fno-threadsafe-statics # Do not emit code for safe init of statics.

# Linker flags.
LDFLAGS += -Wl,--gc-sections # Enable gc of unused input sections.
LDFLAGS += -Wl,--build-id # Enable build id into .note.gnu.build-id section.

# Map flags.
MAPFLAGS += -Wl,-Map=$(*).map # Output some information about the link.
MAPFLAGS += -Wl,--cref # Output a cross reference table.

# Debug linking output.
ifeq ($(V),99)
LDFLAGS += -Wl,--print-gc-sections
endif
