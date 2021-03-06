#
# piaware client-side top-level Makefile
#

# locate the config directory of the init system
SYSTEMD := $(shell ls -d /etc/systemd/system/ 2>/dev/null)
SYSVINIT := $(shell ls -d /etc/init.d/ 2>/dev/null)

all:
	@echo "'make install' as root to install client package and program"

install:
	$(MAKE) -C package install
	$(MAKE) -C programs/piaware install
	$(MAKE) -C programs/piaware-config install
	$(MAKE) -C programs/piaware-status install
	$(MAKE) -C doc install

# conditionally install init services
ifdef SYSVINIT
	install scripts/piaware-rc-script $(SYSVINIT)piaware
else
ifdef SYSTEMD
	install scripts/piaware.service $(SYSTEMD)
else
	@echo "No init service found"
endif
endif

