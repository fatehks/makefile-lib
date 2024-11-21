# tools.makefile

# Updated: <2024-11-21 12:36:55 david.hisel>

# 
CURL = curl
JQ   = jq
AWK  = awk

TOOLS_ALL_CHECK = $(CURL) $(JQ) $(AWK) $(TOOLS)
TOOLS_ALL := $(foreach exec,$(TOOLS_ALL_CHECK),\
        $(if $(shell command -v $(exec)),$(exec),$(warning "WARN: No $(exec) in PATH")))

vardump::  ## echo make variables
	@echo "tools.makefile: CURL: $(CURL)"
	@echo "tools.makefile: JQ: $(JQ)"
	@echo "tools.makefile: AWK: $(AWK)"
	@echo "tools.makefile: TOOLS AVAILABLE: $(TOOLS_ALL)"
