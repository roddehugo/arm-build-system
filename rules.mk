# ARM Cortex-M build system.

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

$(OBJDIR)/%.o: %.S | $(OBJDIR)
	@echo "AS    $<"
	$(call mkdir_if_needed,$@)
	$(Q)$(CC) $(ASFLAGS) $(CPPFLAGS) -o $@ -c $<

$(OBJDIR)/%.o: %.c | $(OBJDIR)
	@echo "CC    $<"
	$(call mkdir_if_needed,$@)
	$(Q)$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<

$(OBJDIR)/%.o: %.cc | $(OBJDIR)
	@echo "CXX   $<"
	$(call mkdir_if_needed,$@)
	$(Q)$(CXX) $(CXXFLAGS) $(CPPFLAGS) -o $@ -c $<
