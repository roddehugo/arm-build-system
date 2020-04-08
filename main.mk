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
OPT ?= -Os
DEBUG ?= -ggdb3
CSTD ?= -std=gnu99
CXXSTD ?= -std=gnu++11

# Include directories.
INCLUDES += -I.
INCLUDES += -I$(BASE)
INCLUDES += -I$(OBJDIR)

# Linkable libraries.
LDLIBS += $(LIBS:%=-l%)
LDPATHS += -L$(BASE)/ld

# Virtual paths.
vpath %.S $(BASE)
vpath %.c $(BASE)
vpath %.cc $(BASE)

# Include commands.
include $(BUILD)/gcc.mk
include $(BUILD)/bmp.mk

# Include flags.
include $(BUILD)/arch.mk
include $(BUILD)/flags.mk

# Decline objects from source files.
.SECONDARY: $(OBJS)
OBJS := $(filter %.o,$(SOURCES:%.S=$(OBJDIR)/%.o))
OBJS += $(filter %.o,$(SOURCES:%.c=$(OBJDIR)/%.o))
OBJS += $(filter %.o,$(SOURCES:%.cc=$(OBJDIR)/%.o))

# Main rules.
.PHONY: all build
all: bin hex lst sym map elf size
build: elf size

# Flash/Debug rules.
.PHONY: flash debug
flash: elf size
	$(Q)$(BMP_FLASH) $(PROGRAM).elf

debug: elf size
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
.PHONY: clean distclean
clean:
	@echo "RMDIR $(OBJDIR)"
	$(Q)$(RMDIR) $(OBJDIR)

distclean: clean
	@echo "RM    $(PROGRAM).{bin,hex,lst,sym,map,elf}"
	$(Q)$(RM) $(PROGRAM).{bin,hex,lst,sym,map,elf}

# Making objects directory rule.
$(OBJDIR):
	@echo "MKDIR $@"
	$(Q)$(MKDIR) $@

# Include build rules.
include $(BUILD)/rules.mk

# Include help rules.
include $(BUILD)/print.mk

# Include dependency checking rules.
-include $(OBJS:.o=.d)
