# hcl-mode [![Build status][ci-badge]][ci-link] [![MELPA][melpa-badge]][melpa-link] [![MELPA STABLE][melpa-stable-badge]][melpa-stable-link]

Major mode for [Hashicorp Configuration Language](https://github.com/hashicorp/hcl).

This mode was originally written by
[@syohex](https://github.com/syohex), but became unmaintained, so this
fork (@purcell) is now its official home for MELPA puposes.


## Screenshot

![hcl-mode](image/hcl-mode.png)


## Installation

`hcl-mode` is available on [MELPA](https://melpa.org/) and [MELPA stable](https://stable.melpa.org/)

You can install `hcl-mode` with the following command.

<kbd>M-x package-install [RET] hcl-mode [RET]</kbd>

If you prefer a manual installation, copy `hcl-mode.el` to a directory in
your `load-path`, and be sure to `(require 'hcl-mode)` before use.

## Features

- Syntax highlighting
- Indentation


## Customize Variables

#### `hcl-indent-level`(Default: `2`)

Indentation size


## Sample Configuration

```lisp
(custom-set-variables
 '(hcl-indent-level 4))
```

## See Also

- [terraform-mode](https://github.com/syohex/emacs-terraform-mode): A major mode of terraform configuration file


[ci-badge]: https://github.com/purcell/emacs-hcl-mode/workflows/CI/badge.svg
[ci-link]: https://github.com/purcell/emacs-hcl-mode/actions
[melpa-link]: https://melpa.org/#/hcl-mode
[melpa-stable-link]: https://stable.melpa.org/#/hcl-mode
[melpa-badge]: https://melpa.org/packages/hcl-mode-badge.svg
[melpa-stable-badge]: https://stable.melpa.org/packages/hcl-mode-badge.svg
