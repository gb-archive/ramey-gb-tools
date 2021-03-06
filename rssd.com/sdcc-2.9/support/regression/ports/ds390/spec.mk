# Regression test specification for the ds390 target running with uCsim

ifndef DEV_NULL
  DEV_NULL = /dev/null
endif

# path to uCsim
ifdef SDCC_BIN_PATH
  S51 = $(SDCC_BIN_PATH)/s51
else
  S51A = $(top_builddir)/sim/ucsim/s51.src/s51
  S51B = $(top_builddir)/bin/s51

  S51 = $(shell if [ -f $(S51A) ]; then echo $(S51A); else echo $(S51B); fi)

  SDCCFLAGS += --nostdinc -I$(top_srcdir)
  LINKFLAGS += --nostdlib -L$(top_builddir)/device/lib/build/ds390 
endif

SDCCFLAGS +=-mds390 --less-pedantic -DREENTRANT=reentrant -Wl-r
LINKFLAGS += libds390.lib libsdcc.lib liblong.lib libint.lib libfloat.lib

OBJEXT = .rel
EXEEXT = .ihx

EXTRAS = $(PORT_CASES_DIR)/testfwk$(OBJEXT) $(PORT_CASES_DIR)/support$(OBJEXT)

# Rule to link into .ihx
%$(EXEEXT): %$(OBJEXT) $(EXTRAS)
	$(SDCC) $(SDCCFLAGS) $(LINKFLAGS) $(EXTRAS) $< -o $@

%$(OBJEXT): %.c
	$(SDCC) $(SDCCFLAGS) -c $< -o $@

$(PORT_CASES_DIR)/%$(OBJEXT): $(PORTS_DIR)/$(PORT)/%.c
	$(SDCC) $(SDCCFLAGS) -c $< -o $@

$(PORT_CASES_DIR)/%$(OBJEXT): fwk/lib/%.c
	$(SDCC) $(SDCCFLAGS) -c $< -o $@

# run simulator with 25 seconds timeout
%.out: %$(EXEEXT) $(CASES_DIR)/timeout
	mkdir -p $(dir $@)
	-$(CASES_DIR)/timeout 25 $(S51) -tds390f -S in=$(DEV_NULL),out=$@ $< < $(PORTS_DIR)/ds390/uCsim.cmd > $(@:.out=.sim) || \
          echo -e --- FAIL: \"timeout, simulation killed\" in $(<:$(EXEEXT)=.c)"\n"--- Summary: 1/1/1: timeout >> $@
	python $(srcdir)/get_ticks.py < $(@:.out=.sim) >> $@
	-grep -n FAIL $@ /dev/null || true

$(CASES_DIR)/timeout: fwk/lib/timeout.c
	$(CC) $(CFLAGS) $< -o $@

_clean:
