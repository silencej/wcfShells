;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keyword: macSet
;; Mac os
; 'Mac'nize.
(when (eq system-type 'darwin)

;(setq load-path (cons "/picb/home52/wangcf/shells/emacsEls" load-path))
; (setq-default shell-cd-regexp "cd\\|cdw")
(setq mac-option-modifier 'meta)
(setq mac-command-key-is-meta nil)
;;use mac-key-mode package.
(when (fboundp 'mac-key-mode)
;  (require 'redo) ; redo.el.
  (require 'mac-key-mode)
  (mac-key-mode 1))

; (global-set-key [?\C-,] (lambda () (interactive) (term "/bin/bash"))) ; C-,
)


; (setq x-select-enable-clipboard t) ; make emacs use the clipboard.
; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
; When the -nw is used, the interprograme-paste should be off.
(when (and (eq system-type 'darwin) (eq window-system nil) )
	(setq x-select-enable-clipboard nil)
	(setq interprogram-paste-function nil)
)
