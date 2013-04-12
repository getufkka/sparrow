all: setup js2-mode.elc

js2-mode.elc: setup
	cd .emacs.d && emacs --batch -f batch-byte-compile js2-mode.el

PHONY: setup
setup:
	./setup.sh
