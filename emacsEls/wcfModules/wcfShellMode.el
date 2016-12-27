;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keyword: windowsSet
;; Windows
(when (eq system-type 'windows-nt)

;(set-default-font "-outline-Courier New-normal-normal-normal-mono-16-*-*-*-c-*-iso8859-1")
;; Use consolas for latin-3 charset.
;; (when (equal system-type "windows-nt")
;; 	(set-fontset-font "fontset-default" 'iso-8859-3 "-outline-Consolas-normal-normal-normal-mono-16-*-*-*-c-*-iso8859-1")
;; 	;; Chinese fontset.
;; 	(set-fontset-font "fontset-default" 'unicode "-outline-微软雅黑-normal-normal-normal-sans-16-*-*-*-p-*-iso8859-1")
;; 	(set-fontset-font "fontset-default" 'han "-outline-微软雅黑-normal-normal-normal-sans-16-*-*-*-p-*-iso8859-1")
;; )


(global-set-key [?\C-,] 'shell) ; C-,
;      (setq explicit-shell-file-name "e:/proGreen/shells/bash.exe")
(setq explicit-shell-file-name "cmdproxy.exe")
;(setq explicit-shell-file-name "powershell.exe")
(setq shell-file-name explicit-shell-file-name)
;      (setq process-coding-system-alist '(("e:/proGreen/shells/bash.exe" . gbk)))
(setq process-coding-system-alist '(("cmdproxy.exe" . gbk)))
;(global-set-key [?\C-.] 'dirs) ; C-.
; (global-set-key [?\C-.] 'dirtrack-mode)
(global-set-key [?\C-.] 'dirs)

(require 'dirtrack)
(defun my-dirtrack-mode ()
  "Add to shell-mode-hook to use dirtrack mode in my shell buffers."
;  (when (member (buffer-name) my-shells)
    (shell-dirtrack-mode 0)
    (dirtrack-mode 1)
    (set-variable 'dirtrack-list '("^.*[^ ]+:\\(.*\\)>" 1 nil))
	;)
)
(add-hook 'shell-mode-hook 'my-dirtrack-mode)

; (add-hook 'shell-mode-hook
; 	(progn
; ;		(dirtrack-mode t) (shell-dirtrack-mode t)
; 		(setq dirtrack-list (list "^\\([a-zA-Z\-]:.*\\)>" 1))
; 	)
; ) ; dirtrack-mode doesn't accept args and it defaults to off.
;(cua-mode t) ; used for C-c copy in windows OS. Not so good, in my opinion.
)

;; Mac OS
(when (eq system-type 'darwin)
  (setq explicit-shell-file-name "/bin/bash")
  (setq shell-file-name "bash")
  (setq explicit-bash.exe-args '("--noediting" "--login" "-i"))
  (setenv "SHELL" shell-file-name)
  (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
)

;; Multi-term
(when (or (eq system-type 'gnu/linux) (eq system-type 'darwin))
	(require 'multi-term)
	(global-set-key (kbd "<f7> m") nil)
	(global-set-key (kbd "<f7> m t") 'multi-term)
	(setq multi-term-program "/bin/bash")
	; Increase buffer from 2048 to larger:
	(add-hook 'term-mode-hook
    (lambda ()
      (setq term-buffer-maximum-size 10000)))
	(add-hook 'term-mode-hook (lambda()
    (yas-minor-mode -1)))
  ; Add shortcuts:
  (add-hook 'term-mode-hook
    (lambda ()
      (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
      (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))
      (add-to-list 'term-bind-key-alist '("C-c C-k" . term-char-mode))
      (add-to-list 'term-bind-key-alist '("C-c C-j" . term-line-mode))))
)
