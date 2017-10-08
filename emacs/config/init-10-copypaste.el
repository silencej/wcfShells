;; Copy and Paste.
(setq kill-whole-line nil)
(delete-selection-mode t) ;transient-mark-mode will be set t automatically after this. In this mode, pasting replaces the selected text with the contents of the clipboard.

(defun wcfCopyCurrentWord ()
  (interactive)
  (forward-word)
  (let ((end (point)))
    (backward-word)
    (kill-ring-save (point) end)
;    (query-replace (current-kill 0) replace-str)
	)
)
(bind-key* "<f7> c w" 'wcfCopyCurrentWord)

;;;;;;;;;; Mac OS

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
  ;	(setq-default select-enable-clipboard nil)
  ;	(setq interprogram-paste-function nil)
  
  (defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))
  
  (defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
  (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
  (process-send-string proc text)
  (process-send-eof proc))))
  
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx)
  )

(when (eq system-type 'gnu/linux)
 (use-package xclip
   :config (xclip-mode 1)
 )
)
