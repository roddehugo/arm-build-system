# Run mkdir if directory does not exists.
# $(call mkdir_if_needed,FILE)
mkdir_if_needed = $(if $(wildcard $(dir $1)),,$(Q)$(MKDIR) $(dir $1))
