;;; kill-term-buffer-on-exit-mode.el --- Kill `term` buffers when associated process terminates
;;
;;; Copyright (C) 2018  Free Software Foundation, Inc.
;;
;; Author: Eric Crosson <eric.s.crosson@utexas.com>
;; Version: 1.0.0
;; Keywords: convenience
;; URL: https://github.com/EricCrosson/kill-term-buffer-on-exit-mode
;; Package-Requires: ((emacs "24"))
;;
;; This file is not a part of GNU Emacs.
;;
;;
;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.
;;
;;
;;; Commentary:
;;
;; Kill `term' buffers when associated process terminates.

;;; Code:


;;;###autoload
(define-minor-mode kill-term-buffer-on-exit-mode
  "When active, kill `term' buffers when associated process terminates."
  :init-value nil
  :lighter nil
  :keymap (make-sparse-keymap)
  :global t
  :group 'kill-term-buffer-on-exit
  :require 'kill-term-buffer-on-exit-mode)


(defun term-kill-buffer-on-exit (process-name msg)
  "Kill `term' buffer after associated process terminates.
Ignore PROCESS-NAME and MSG."
  (kill-buffer))

(defun toggle-kill-term-buffer-on-exit ()
  "Advise `term-handle-exit' if `term-kill-buffer-on-exit' mode is
active, else un-advise."
  (if kill-term-buffer-on-exit-mode
      (advice-add 'term-handle-exit :after 'term-kill-buffer-on-exit)
    (advice-remove 'term-handle-exit 'term-kill-buffer-on-exit)))


(add-hook 'kill-term-buffer-on-exit-mode-hook 'toggle-kill-term-buffer-on-exit)

(kill-term-buffer-on-exit-mode 1)

(provide 'kill-term-buffer-on-exit-mode)

;;; kill-term-buffer-on-exit-mode.el ends here
