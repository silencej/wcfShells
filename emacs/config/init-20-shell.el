
;;;;;;;;;; Shell mode

;;;;; Automatic rename shell buffer
; http://ann77.emacser.com/Emacs/EmacsShellAutoDirName.html

(make-variable-buffer-local 'wcy-shell-mode-directory-changed)
(setq wcy-shell-mode-directory-changed t)

; Have support for ANSI color
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun wcf-rename-shell-buffer-when-start()
  (let ((bn (concat "*sh:" (file-name-base (directory-file-name default-directory)) "*")))
    (if (not (string= (buffer-name) bn))
        (rename-buffer bn t))))

(defun wcy-shell-mode-auto-rename-buffer-output-filter (text)
  (if (and (eq major-mode 'shell-mode)
           wcy-shell-mode-directory-changed)
      (progn
				(wcf-rename-shell-buffer-when-start)
        (setq wcy-shell-mode-directory-changed nil))))

(defun wcy-shell-mode-auto-rename-buffer-input-filter (text)
  (if (eq major-mode 'shell-mode)
      (if ( string-match "^[ \t]*cd *" text)
          (setq wcy-shell-mode-directory-changed t))))
(add-hook 'comint-output-filter-functions 'wcy-shell-mode-auto-rename-buffer-output-filter)
(add-hook 'comint-input-filter-functions 'wcy-shell-mode-auto-rename-buffer-input-filter )
(add-hook 'shell-mode-hook 'wcf-rename-shell-buffer-when-start)

;;;;; Search

(use-package ag
  :ensure t
  :defer t
)

;;;;;;;;;; Windows

; http://www.ibm.com/developerworks/cn/linux/l-cn-emacs-shell2/index.html
(defun kill-shell-buffer(process event)
  "The one actually kill shell buffer when exit. "
  (kill-buffer (process-buffer process))
)
(defun kill-shell-buffer-after-exit()
  "kill shell buffer when exit."
  (set-process-sentinel (get-buffer-process (current-buffer))
                #'kill-shell-buffer)
)
(add-hook 'shell-mode-hook 'kill-shell-buffer-after-exit t)

(when (eq system-type 'windows-nt)

;; NOTE: Term mode is still not working on Windows for term. Use shell or eshell instead.

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
; cmdproxy which is part of Emacs install
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

(when (or (eq system-type 'gnu/linux) (eq system-type 'darwin))
	(use-package multi-term
		:ensure t
		:bind* (
			("<f7> m t" . multi-term))
		:config
		(setq multi-term-program "/bin/bash")
		; Increase buffer from 2048 to larger:
  	(add-hook 'term-mode-hook
      (lambda ()
        (setq term-buffer-maximum-size 10000)))
		(when (fboundp 'yas-minor-mode)
	  	(add-hook 'term-mode-hook (lambda()
		    (yas-minor-mode -1))))
    ; Add shortcuts:
    (add-hook 'term-mode-hook
      (lambda ()
        (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
        (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))
        (add-to-list 'term-bind-key-alist '("C-c C-k" . term-char-mode))
        (add-to-list 'term-bind-key-alist '("C-c C-j" . term-line-mode))
				(wcf-rename-shell-buffer-when-start)
			)
		)
	)

	(use-package kill-term-buffer-on-exit-mode
		:load-path "~/wcfShells/emacs/packages"
		:ensure nil
	)
	; May need: quelpa-use-package
  ; (use-package kill-term-buffer-on-exit-mode
  ;   :quelpa (kill-term-buffer-on-exit-mode
  ;            :fetcher github
  ;            :repo "EricCrosson/kill-term-buffer-on-exit-mode"))

	; TODO: not work on Mac: no /proc/ directory.
	; https://stackoverflow.com/questions/13655782/update-multi-term-buffer-name-based-on-pwd
	; Credits: Albert K
  (defadvice term-send-input (after update-current-directory)
    (run-at-time "0.1 sec" nil 'term-update-dir)
    )
  (ad-activate 'term-send-input)
  (defadvice term-send-return (after update-current-directory)
    (run-at-time "0.1 sec" nil 'term-update-dir)
    )
  (ad-activate 'term-send-return)
  (defun term-update-dir ()
		(wcf-rename-shell-buffer-when-start)
  )
)
