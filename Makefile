EMACS ?= emacs
BATCH_W_ERROR = -batch --eval "(setq byte-compile-error-on-warn t)"

# A space-separated list of required package names
NEEDED_PACKAGES = package-lint

INIT_PACKAGES="(progn \
  (require 'package) \
  (push '(\"melpa\" . \"https://melpa.org/packages/\") package-archives) \
  (package-initialize) \
  (dolist (pkg '(${NEEDED_PACKAGES})) \
    (unless (package-installed-p pkg) \
      (unless (assoc pkg package-archive-contents) \
	(package-refresh-contents)) \
      (package-install pkg))) \
  )"

all: compile-tests test package-lint clean-elc

package-lint:
	${EMACS} --eval ${INIT_PACKAGES} $(BATCH_W_ERROR) -f package-lint-batch-and-exit hcl-mode.el

hcl-mode.elc: hcl-mode.el Makefile
	${EMACS} $(BATCH_W_ERROR) -f batch-byte-compile $<

test/test-helper.elc: test/test-helper.el hcl-mode.elc
	${EMACS} -L . $(BATCH_W_ERROR) -f batch-byte-compile $<

TESTS-EL = test/test-command.el test/test-highlighting.el test/test-indentation.el
TESTS-ELC = test/test-command.elc test/test-highlighting.elc test/test-indentation.elc
$(TESTS-ELC): test/test-helper.elc hcl-mode.elc $(TESTS-EL)
	${EMACS} -L . -l test/test-helper.elc $(BATCH_W_ERROR) -f batch-byte-compile test/test-command.el test/test-highlighting.el test/test-indentation.el
compile-tests: $(TESTS-ELC)

test: $(TESTS-ELC)
	$(EMACS) -L . -batch \
		-l test/test-helper.elc \
		-l test/test-indentation.elc \
		-l test/test-command.elc \
		-l test/test-highlighting.elc \
		-f ert-run-tests-batch-and-exit

clean-elc:
	rm -f f.elc

.PHONY:	all clean-elc package-lint test
