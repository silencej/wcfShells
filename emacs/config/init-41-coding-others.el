;;;;;;;;;;;; Common

;; Editorconfig
; It is not in Melpa, so we add it manually.
(add-to-list 'load-path "~/wcfShells/emacs/packages/editorconfig")
(require 'editorconfig)
(editorconfig-mode 1)

(use-package magit)

;; Etag


(use-package yaml-mode
	:config
	(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
)

(when (or (equal system-type 'ms-dos) (equal system-type 'windows-nt))
  (use-package dos)
)
;	:config
;	(add-to-list 'auto-mode-alist '("\\.bat$" . dos-mode))
; (autoload 'dos-mode "dos" "Edit Dos scripts." t)

; (use-package auto-complete
; ; (use-package auto-complete-config
; 	:config
; 	(ac-config-default)
;   ; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
;   (defun my:ac-c-header-init ()
;     (require 'auto-complete-c-headers)
;     (add-to-list 'ac-sources 'ac-source-c-headers)
;   ;  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include")
;   )
; )

; ; start auto-complete with emacs
; (require 'auto-complete)
; ; do default config for auto-complete
; (require 'auto-complete-config)
; (ac-config-default)


; ------ yasnippet
(add-to-list 'load-path "~/wcfShells/emacs/yasnippet")
(use-package yasnippet
	:config
	(add-to-list 'yas-snippet-dirs "~/wcfShells/emacs/snippets")
	(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
	(setq-default yas-indent-line 'fixed) ;; The other choice is auto, which causes trouble for me.
; Prevent key def loop between auto-complete.
; (setq yas-fallback-behavior 'return-nil)
; wcf fix: M-x yas-minor-mode. Disable it.
)


(use-package json-mode
	:config
	(setq-default json-reformat:pretty-string? t) ; Note the last '?' in the varName.
	(setq-default json-reformat:indent-width 2)
)

(use-package autoit-mode
	:ensure nil
	:load-path "~/wcfShells/emacs/packages/autoit"
	:config
	(add-to-list 'auto-mode-alist
    '("\\.au3" . autoit-mode)
	)
)

(use-package dockerfile-mode
)

(use-package docker-compose-mode
)

(use-package nginx-mode
)

; ---------- Golang

(use-package go-mode
  :ensure t
  :defer t
)
(add-hook 'before-save-hook #'gofmt-before-save)
(use-package company-go
  :ensure t
  :defer t
;	:config
;  (add-hook 'go-mode-hook
;     (lambda ()
;       (set (make-local-variable 'company-backends) '(company-go))
;       (company-mode)))
)

;; from https://www.youtube.com/watch?v=r6j2W5DZRtA
;; get the following packages ("M-x package-list-packages"):
;;     go-mode
;;     go-eldoc
;;     company-mode
;;     company-go
;; get the following go programs (run each line in your shell):
;;     go get golang.org/x/tools/cmd/godoc
;;     go get golang.org/x/tools/cmd/goimports
;;     go get github.com/rogpeppe/godef
;;     go get github.com/nsf/gocode

(setq company-idle-delay 0.25)

; (setq gofmt-command "goimports")
; ;; UPDATE: gofmt-before-save is more convenient then having a command
; ;; for running gofmt manually. In practice, you want to
; ;; gofmt/goimports every time you save anyways.
; (add-hook 'before-save-hook 'gofmt-before-save)
; 
; (global-set-key (kbd "C-c M-n") 'company-complete)
; (global-set-key (kbd "C-c C-n") 'company-complete)
; 
; (defun my-go-mode-hook ()
;   ;; UPDATE: I commented the next line out because it isn't needed
;   ;; with the gofmt-before-save hook above.
;   ;; (local-set-key (kbd "C-c m") 'gofmt)
;   (local-set-key (kbd "M-.") 'godef-jump))
;   (set (make-local-variable 'company-backends) '(company-go))
; 
; (add-hook 'go-mode-hook 'my-go-mode-hook)
; (add-hook 'go-mode-hook 'go-eldoc-setup)
; (add-hook 'go-mode-hook 'company-mode)

