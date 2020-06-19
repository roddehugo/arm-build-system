# ARM Cortex-M build system.

# Project Makefile must specify top-level directory.
ifeq ($(BASE),)
$(error BASE is not defined)
endif

# Check PROGRAM is defined.
ifeq ($(PROGRAM),)
$(error PROGRAM is not defined)
endif

# Check TARGET is defined.
ifeq ($(TARGET),)
$(error TARGET is not defined)
endif

# Check SOURCES are specified.
ifeq ($(SOURCES),)
$(error SOURCES are not specified)
endif

# Be silent per default, but 'make V=1' will show all compiler calls.
ifneq ($(V),1)
Q = @
MAKEFLAGS += --no-print-directory
endif

# Get directory of this Makefile.
BUILD := $(patsubst %/main.mk,%,$(lastword $(MAKEFILE_LIST)))

# Directory commands.
RM := rm -f
RMDIR := rm -rf
MKDIR := mkdir -p

# Objects directory.
OBJDIR := obj

# Include make macros.
include $(BUILD)/macros.mk

# User defined compilation flags.
OPT ?= -Og # Define optimization level (0, 1, 2, 3, s, g).
DEBUG ?= -g3 # Define debug level (0, 1, 3).
CSTD ?= # Define C standard to use for C sources.
CXXSTD ?= # Define C++ standard to use for C++ sources.
DEPS ?= -MP -MMD # Emit dummy dependency rules for user header files.

# Include directories.
INCLUDES = -I. -I$(BASE) -I$(OBJDIR)

# Compiler flags.
CFLAGS = $(OPT) $(DEBUG) $(INCLUDES)
CXXFLAGS = $(CFLAGS) # Extend CFLAGS.
CPPFLAGS = $(DEFS) $(DEPS)

# Linkable libraries.
LDLIBS += $(LIBS:%=-l%) # Caveat for user defined libraries.

# Virtual paths.
vpath %.S $(BASE)
vpath %.c $(BASE)
vpath %.cc $(BASE)

# Main rules.
.PHONY: all build
all: bin hex lst sym map elf size
build: lst sym elf size

# Include commands.
include $(BUILD)/gcc.mk
include $(BUILD)/bmp.mk

# Include flags.
include $(BUILD)/arch.mk
include $(BUILD)/flags.mk

# Make sure to rebuild sources if defines change.
$(eval $(call cmddep,DEFS,$(OBJDIR)/defs.old))
OBJDEPS += $(OBJDIR)/defs.old

# Decline objects from source files.
.SECONDARY: $(OBJS)
OBJS := $(filter %.o,$(SOURCES:%.S=$(OBJDIR)/%.o))
OBJS += $(filter %.o,$(SOURCES:%.c=$(OBJDIR)/%.o))
OBJS += $(filter %.o,$(SOURCES:%.cc=$(OBJDIR)/%.o))

# Flash/Debug rules.
.PHONY: flash debug
flash: build
	$(Q)$(BMP_FLASH) $(PROGRAM).elf

debug: build
	$(Q)$(BMP_DEBUG) $(PROGRAM).elf

# Binary rules.
.PHONY: bin hex lst sym map elf
bin: $(PROGRAM).bin
hex: $(PROGRAM).hex
lst: $(PROGRAM).lst
sym: $(PROGRAM).sym
map: $(PROGRAM).map
elf: $(PROGRAM).elf

# Size rule.
.PHONY: size
size: $(PROGRAM).elf
	@echo "SIZE  $<"
	$(Q)$(BUILD)/tools/print-fw-size $< $(LDSCRIPT) $(SIZE)

# Cleaning rules.
.PHONY: clean
clean:
	@echo "RMDIR $(OBJDIR)"
	$(Q)$(RMDIR) $(OBJDIR)
	@echo "RM    $(PROGRAM).{bin,hex,lst,sym,map,elf}"
	$(Q)$(RM) $(PROGRAM).{bin,hex,lst,sym,map,elf}

# Linker script check.
# $(LDSCRIPT):
# 	$(error Linker script $(LDSCRIPT) not found)

# Making objects directory rule.
$(OBJDIR):
	@echo "MKDIR $@"
	$(Q)$(MKDIR) $@

# Binary rules.
%.bin: %.elf
	@echo "BIN   $@"
	$(Q)$(OBJCOPY) -O binary $< $@

%.hex: %.elf
	@echo "HEX   $@"
	$(Q)$(OBJCOPY) -O ihex $< $@

%.lst: %.elf
	@echo "LST   $@"
	$(Q)$(OBJDUMP) -h -S $< > $@

%.sym: %.elf
	@echo "SYM   $@"
	$(Q)$(NM) -l -n -S $< > $@

%.map: $(OBJS) $(LIBDEPS) $(LDSCRIPT)
	@echo "MAP   $@"
	$(Q)$(LD) $(LDFLAGS) $(MAPFLAGS) $(OBJS) $(LDLIBS) -o $@

%.elf: $(OBJS) $(LIBDEPS) $(LDSCRIPT)
	@echo "LD    $@"
	$(Q)$(LD) $(LDFLAGS) $(OBJS) $(LDLIBS) -o $@

# Object rules.
$(OBJDIR)/%.o: %.S $(OBJDEPS) | $(OBJDIR)
	@echo "AS    $<"
	$(call mkdir_if_needed,$@)
	$(Q)$(CC) $(ASFLAGS) $(CPPFLAGS) -o $@ -c $<

$(OBJDIR)/%.o: %.c $(OBJDEPS) | $(OBJDIR)
	@echo "CC    $<"
	$(call mkdir_if_needed,$@)
	$(Q)$(CC) $(CSTD) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<

$(OBJDIR)/%.o: %.cc $(OBJDEPS) | $(OBJDIR)
	@echo "CXX   $<"
	$(call mkdir_if_needed,$@)
	$(Q)$(CXX) $(CXXSTD) $(CXXFLAGS) $(CPPFLAGS) -o $@ -c $<

# Include help rules.
include $(BUILD)/print.mk

# Include libopencm3.
include $(BUILD)/libopencm3.mk

# Include dependency checking rules.
-include $(OBJS:.o=.d)
