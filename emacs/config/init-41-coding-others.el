;;;;;;;;;;;; Common

;; Editorconfig
; It is not in Melpa, so we add it manually.
(add-to-list 'load-path "~/wcfShells/emacs/packages/editorconfig")
(require 'editorconfig)
(editorconfig-mode 1)

;; Etag




(use-package dos
	:config
	(add-to-list 'auto-mode-alist '("\\.bat$" . dos-mode))
	)
; (autoload 'dos-mode "dos" "Edit Dos scripts." t)
; (add-to-list 'auto-mode-alist '("\\.bat$" . dos-mode))


(use-package auto-complete
; (use-package auto-complete-config
	:config
	(ac-config-default)
  ; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
  (defun my:ac-c-header-init ()
    (require 'auto-complete-c-headers)
    (add-to-list 'ac-sources 'ac-source-c-headers)
  ;  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include")
  )
)
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

; (use-package flymake-
