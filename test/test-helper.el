;;; test-helper.el --- helper for testing hcl-mode  -*- lexical-binding: t -*-

;; Copyright (C) 2017 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'hcl-mode)

(if (fboundp 'font-lock-ensure)
    (defalias 'hcl-mode--font-lock-ensure 'font-lock-ensure)
  ;; `font-lock-ensure' didn't exist prior to Emacs 25
  (defun hcl-mode--font-lock-ensure ()
    (with-no-warnings (font-lock-fontify-buffer))))

(defmacro with-hcl-temp-buffer (code &rest body)
  "Insert `code' and enable `hcl-mode'. cursor is beginning of buffer"
  (declare (indent 0) (debug t))
  `(with-temp-buffer
     (insert ,code)
     (goto-char (point-min))
     (hcl-mode)
     (hcl-mode--font-lock-ensure)
     ,@body))

(defun forward-cursor-on (pattern)
  (let ((case-fold-search nil))
    (re-search-forward pattern))
  (goto-char (match-beginning 0)))

(defun backward-cursor-on (pattern)
  (let ((case-fold-search nil))
    (re-search-backward pattern))
  (goto-char (match-beginning 0)))

(defun face-at-cursor-p (face)
  (eq (face-at-point) face))

;;; test-helper.el ends here
