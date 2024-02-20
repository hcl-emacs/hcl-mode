EMACS ?= emacs

# A space-separated list of required package names
NEEDED_PACKAGES = package-lint ert

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

all: compile test package-lint clean-elc

package-lint:
	${EMACS} --eval ${INIT_PACKAGES} -batch -f package-lint-batch-and-exit hcl-mode.el

compile: clean-elc
	${EMACS} --eval ${INIT_PACKAGES} -L . -batch -f batch-byte-compile *.el

test:
	$(EMACS) --eval ${INIT_PACKAGES} -L . -batch \
		-l test/test-helper.el \
		-l test/test-indentation.el \
		-l test/test-command.el \
		-l test/test-highlighting.el \
		-f ert-run-tests-batch-and-exit

clean-elc:
	rm -f f.elc

.PHONY:	all compile clean-elc package-lint test
