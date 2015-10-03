;;; tab-jump-out.el --- Use tab to jump out

;; Copyright (C) 2015 Zhang Kai Yu

;; Author: Zhang Kai Yu <yeannylam@gmail.com>
;; Keywords: tab, editing
;; Package-Requires: ((dash "2.10"))

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

;;

;;; Code:

(require 'dash)

(defgroup tab-jump-out nil
  "Custom group for `tab-jump-out-mode'."
  :group 'editing
  :prefix "tab-jump-out-")

(defvar-local tab-jump-out-delimiters '(";" ")" "]" "}" "|" "'" "\"" "`")
  "The delimiters indicate `tab-jump-out' should jump out.")

(defun tab-jump-out-fallback ()
  "Fallback behavior of `tab-jump-out'."
  (let ((fallback-behavior (tab-jump-out-original-keybinding)))
    (if fallback-behavior
        (call-interactively fallback-behavior))))

(defun tab-jump-out-original-keybinding ()
  "Get current keys' binding as if `tab-jump-out-' didn't exist."
  ;; Copied from yasnippet, didn't handle
  ;; yas--fallback-translate-input yet.
  (let* ((tab-jump-out-mode nil)
         (keys (this-single-command-keys)))
    (key-binding keys t)))

(defun tab-jump-out (arg)
  "Use tab to jump out."
  (interactive "P")
  (if (-contains? tab-jump-out-delimiters (char-to-string (char-after)))
      (forward-char arg)
    (tab-jump-out-fallback)))

(defvar tab-jump-out-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [tab] 'tab-jump-out)
    map)
  "Keymap for `tab-jump-out-mode'.")

(define-minor-mode tab-jump-out-mode
  "A minor mode that allows you to jump out with tab."
  :keymap tab-jump-out-mode-map)

(provide 'tab-jump-out)
;;; tab-jump-out.el ends here
