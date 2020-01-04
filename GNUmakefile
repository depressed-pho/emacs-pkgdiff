EMACS ?= emacs

ELC_FILES = pkgdiff.elc

.PHONY: all
all: $(ELC_FILES)

%.elc: %.el
	$(EMACS) --no-init-file --no-site-file -batch \
		-f batch-byte-compile $<

.PHONY: clean
clean:
	rm -f $(ELC_FILES)
