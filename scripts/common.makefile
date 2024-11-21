# common.makefile

# Updated: <2024-11-21 13:29:11 david.hisel>

.PHONY: scripts/tools.makefile
include scripts/tools.makefile

OS := $(shell uname -s| $(AWK) '{print tolower($0)}')
ARCH := $(shell uname -m| $(AWK) '{print tolower($0)}')

VERSION_FILE := $(shell if [ ! -f VERSION ]; then $(AWK) 'BEGIN{print "0.0.1"}' >VERSION; fi)

VERSION_MAJOR := $(shell $(AWK) -F. '{print $$1}' VERSION)
VERSION_MINOR := $(shell $(AWK) -F. '{print $$2}' VERSION)
VERSION_PATCH := $(shell $(AWK) -F. '{print $$3}' VERSION)
VERSION  = $(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_PATCH)

NEXT_VERSION_MAJOR := $(shell $(AWK) -F. '{print $$1+1"."$$2"."$$3}' VERSION)
NEXT_VERSION_MINOR := $(shell $(AWK) -F. '{print $$1"."$$2+1"."$$3}' VERSION)
NEXT_VERSION_PATCH := $(shell $(AWK) -F. '{print $$1"."$$2"."$$3+1}' VERSION)

help: ## show help
	@echo "The following build targets have help summaries:"
	@$(AWK) 'BEGIN{FS=":.*[#][#]"} /[#][#]/ && !/^#/ {h[$$1":"]=$$2}END{n=asorti(h,d);for (i=1;i<=n;i++){printf "%-26s%s\n", d[i], h[d[i]]}}' $(MAKEFILE_LIST)
	@echo

bumpversionmajor:  ## increment MAJOR number in VERSION file
	@echo "$(NEXT_VERSION_MAJOR)" > VERSION

bumpversionminor:  ## increment MINOR number in VERSION file
	@echo "$(NEXT_VERSION_MINOR)" > VERSION

bumpversionpatch:  ## increment PATCH number in VERSION file
	@echo "$(NEXT_VERSION_PATCH)" > VERSION

.PHONY: help bumpversionmajor bumpversionminor bumpversionpatch

vardump::  ## echo make variables
	@echo "common.makefile: OS: $(OS)"
	@echo "common.makefile: ARCH: $(ARCH)"
	@echo "common.makefile: VERSION: $(VERSION)"
	@echo "common.makefile: VERSION_MAJOR: $(VERSION_MAJOR)"
	@echo "common.makefile: VERSION_MINOR: $(VERSION_MINOR)"
	@echo "common.makefile: VERSION_PATCH: $(VERSION_PATCH)"
	@echo "common.makefile: NEXT_VERSION_MAJOR: $(NEXT_VERSION_MAJOR)"
	@echo "common.makefile: NEXT_VERSION_MINOR: $(NEXT_VERSION_MINOR)"
	@echo "common.makefile: NEXT_VERSION_PATCH: $(NEXT_VERSION_PATCH)"

clean:: ## clean ephemeral build resources

realclean:: clean  ## clean all resources that can be re-made

bootstrap::  ## install tools and setup environment
ifndef BINDIR
	$(error "BINDIR is not set")
endif

.PHONY: vardump clean realclean bootstrap

