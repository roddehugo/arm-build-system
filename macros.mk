# ucoolib - Microcontroller object oriented library.

# Run mkdir if directory does not exists.
# $(call mkdir_if_needed,FILE)
mkdir_if_needed = $(if $(wildcard $(dir $1)),,$(Q)$(MKDIR) $(dir $1))

# Evaluate B only if A is defined, i.e. if the variable's origin is
# anything but undefined.
# $(call ifdefined,A,B)
ifdefined = $(if $(filter-out undefined,$(origin $1)),$2)

# Convert to uppercase.
# $(call toupper,string)
toupper = $(strip \
	$(subst a,A,$(subst b,B,$(subst c,C,$(subst d,D,$(subst e,E,\
	$(subst f,F,$(subst g,G,$(subst h,H,$(subst i,I,$(subst j,J,\
	$(subst k,K,$(subst l,L,$(subst m,M,$(subst n,N,$(subst o,O,\
	$(subst p,P,$(subst q,Q,$(subst r,R,$(subst s,S,$(subst t,T,\
	$(subst u,U,$(subst v,V,$(subst w,W,$(subst x,X,$(subst y,Y,\
	$(subst z,Z,$1)))))))))))))))))))))))))))

# Convert to lowercase.
# $(call tolower,string)
tolower = $(strip \
	$(subst A,a,$(subst B,b,$(subst C,c,$(subst D,d,$(subst E,e,\
	$(subst F,f,$(subst G,g,$(subst H,h,$(subst I,i,$(subst J,j,\
	$(subst K,k,$(subst L,l,$(subst M,m,$(subst N,n,$(subst O,o,\
	$(subst P,p,$(subst Q,q,$(subst R,r,$(subst S,s,$(subst T,t,\
	$(subst U,u,$(subst V,v,$(subst W,w,$(subst X,x,$(subst Y,y,\
	$(subst Z,z,$1)))))))))))))))))))))))))))

# Handle command line changes.
# The given variable is saved in savefile, which should be included as target
# dependencies.  If variable content is not the same as in previous build, the
# savefile is made phony and the target is rebuilt.
# $(call cmddep,VAR,savefile)
define cmddep
-include $2
.PHONY: $$(if $$(call diff,$$($1_OLD),$$($1)),$2)
$2:
	@echo "DEP   $$@"
	$$(call mkdir_if_needed,$$@)
	$$(Q)echo "$1_OLD = $$($1)" > $$@
endef
