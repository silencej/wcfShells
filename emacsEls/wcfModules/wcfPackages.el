
(setq load-path (cons "~/wcfShells/emacsEls" load-path))
(setq load-path (cons "~/wcfShells/emacsEls/smartparens" load-path))

; (global-set-key (kbd "C-c s f") 'speedbar-get-focus)
;;(require 'sr-speedbar);;这句话是必须的
;;(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));;开启程序即启用
;;(setq-default sr-speedbar-right-side nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; keyword: not in (mac and nw)
; When there is no window system, which is to say, -nw is used in Mac OS, packages with unicode chars will cause emacs init failure. So if not in (mac and nw), these packages can be loaded.

;(when (or (equal window-system t) (and (not (eq system-type 'darwin)) (not (string= system-name "axel-svr1.icb.ac.cn"))) )
(when (or (not (equal window-system nil)) (string= system-name "wangcf-laptop") )

; mac and nw can only dispay ansi-8-colors through putty. So don't set colors for them, set colors here instead.
;; (set-background-color "#FFFFFF")

(require 'unicad) ; unicode charset automatic detector.

; Emacs speaks statistics. Emacs R, SAS mode.
; (load "~/shells/emacsEls/ess/lisp/ess-site")
; (require 'ess-site)
)


; glsl mode.
;(setq load-path (cons "~/.emacs.d" load-path))
(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.cg\\'" . glsl-mode))

; Markdown mode.
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
; (autoload 'markdown-mode "gfm-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
; ;; gfm-mode (Github Flavored Mode) is also provided by markdown-mode.el.
; ;; Remember to turn off visual-line-mode which is automatically brought by gfm-mode.
; (add-to-list 'auto-mode-alist '("\\.text\\'" . gfm-mode))
; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
; (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

; cmake mode.
;(setq load-path (cons (expand-file-name "~/cmake-mode") load-path))
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

; dos-mode, .bat
(autoload 'dos-mode "dos" "Edit Dos scripts." t)
(add-to-list 'auto-mode-alist '("\\.bat$" . dos-mode))



;	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	;; Cedet here to override the default cedet version.
;	
;	;; Load CEDET.
;	;; See cedet/common/cedet.info for configuration details.
;	;; IMPORTANT: Tou must place this *before* any CEDET component (including
;	;; EIEIO) gets activated by another package (Gnus, auth-source, ...).
;	(load-file "~/shells/emacsEls/cedet/cedet-devel-load.el")
;	
;	;; Add further minor-modes to be enabled by semantic-mode.
;	;; See doc-string of `semantic-default-submodes' for other things
;	;; you can use here.
;	(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
;	(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;	(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)
;	
;	;; Enable Semantic
;	(semantic-mode 1)
;	
;	;; Enable EDE (Project Management) features
;	(global-ede-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;
;; add-hook.

;	;; Matlab mode.
;	(add-to-list 'load-path "~/shells/emacsEls/matlab-emacs")
;	(load-library "matlab-load")
;	(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
;	(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
;	(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)
;	;User Level customizations (You need not use them all):
;	(setq matlab-indent-function-body t)  ; if you want function bodies indented
;	(setq matlab-verify-on-save-flag nil) ; turn off auto-verify on save
;	;  (defun my-matlab-mode-hook ()
;	;    (setq fill-column 76))              ; where auto-fill should wrap
;	;(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
;	(defun my-matlab-shell-mode-hook ()
;	      '())
;	(add-hook 'matlab-shell-mode-hook 'my-matlab-shell-mode-hook)
;	; add-hook must use lambda function.
;	(add-hook 'matlab-mode-hook
;		(lambda ()
;			(auto-fill-mode 0))
;	)

;;  ;; To begin using Octave mode for all .m files you visit, add the following lines to a file loaded by Emacs at startup time, typically your ~/.emacs file:
;;  (autoload 'octave-mode "octave-mod" nil t)
;;  (setq auto-mode-alist
;;        (cons '("\\.m$" . octave-mode) auto-mode-alist))
;;  ;; Finally, to turn on the abbrevs, auto-fill and font-lock features automatically, also add the following lines to one of the Emacs startup files:
;;  ;; Turn auto-fill-mode to 0, because it's really annoying.
;;  (add-hook 'octave-mode-hook
;;            (lambda ()
;;              (abbrev-mode 1)
;;              (auto-fill-mode 0)
;;              (if (eq window-system 'x)
;;                  (font-lock-mode 1))
;;            )
;;  )

(require 'undo-tree)
;; "M-x byte-compile-file" from within emacs.
;; If you want to replace the standard Emacs' undo system with the
;; `undo-tree-mode' system in all buffers, you can enable it globally by
;; adding:
(global-undo-tree-mode)

(when (>= emacs-major-version 24)

; (require 'ede-cmake)

(require 'sr-speedbar)
(global-set-key (kbd "M-s s") 'sr-speedbar-toggle)

;; wcf note: remember to run:
;; M-x package-install RET PKGNames RET
;; PKGNames inlcude: auto-complete, auto-complete-c-headers (An auto-complete source for C/C++ header files), yasnippet.

; Author: Baris Yuksel (2014)
; http://barisyuksel.com/cppmode/.emacs

; start yasnippet with emacs
;(require 'yasnippet)
;(yas-global-mode 1)

; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
;  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include")
)

; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

; Fix iedit bug in Mac
; (define-key global-map (kbd "C-c ;") 'iedit-mode)

; ; start flymake-google-cpplint-load
; ; let's define a function for flymake initialization
; (defun my:flymake-google-init () 
;   (require 'flymake-google-cpplint)
;   (custom-set-variables
;    '(flymake-google-cpplint-command "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/cpplint"))
;   (flymake-google-cpplint-load)
; )
; (add-hook 'c-mode-hook 'my:flymake-google-init)
; (add-hook 'c++-mode-hook 'my:flymake-google-init)

; ; start google-c-style with emacs
; (require 'google-c-style)
; (add-hook 'c-mode-common-hook 'google-set-c-style)
; (add-hook 'c-mode-common-hook 'google-make-newline-indent)

(require 'cc-mode)
(setq-default c-basic-offset 4)
(setq-default c-default-style "k&r")

(add-hook 'html-mode-hook
	(lambda ()
	  ;; Default indentation is usually 2 spaces, changing to 4.
	  (set (make-local-variable 'sgml-basic-offset) 4)))

(require 'semantic)
; turn on Semantic
(semantic-mode 1)
(global-semanticdb-minor-mode 1)
; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)
(require 'stickyfunc-enhance)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)

; let's define a function which adds semantic as a suggestion backend to auto complete and hook this function to c-mode-common-hook.
(defun my:add-semantic-to-autocomplete() 
;  (add-to-list 'ac-sources 'ac-source-semantic)
  (add-to-list 'ac-sources 'ac-source-semantic-raw)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

; turn on ede mode 
(require 'ede)
(global-ede-mode 1)

; ; you can use system-include-path for setting up the system header file locations.
; ; create a project for our program.
; (ede-cpp-root-project "my project" :file "~/demos/my_program/src/main.cpp"
; 		      :include-path '("/../my_inc"))

(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; Package: smartparens
; (load-file "~/wcfShells/emacsEls/dash.el")
; (load-file "~/wcfShells/emacsEls/smartparens/smartparens.el")
; (require 'smartparens-config)
; (show-smartparens-global-mode +1)
; (smartparens-global-mode 1)
;; when you press RET, the curly braces automatically add another newline
; (sp-with-modes '(c-mode c++-mode)
;   (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
;   (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
;                                            ("* ||\n[i]" "RET"))))

);; When emacs version >=24 ends.

; ------ yasnippet
(add-to-list 'load-path "~/wcfShells/emacsEls/yasnippet")
(require 'yasnippet)
(add-to-list 'yas-snippet-dirs "~/wcfShells/emacsEls/wcfSnippets")
(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
(setq-default yas-indent-line 'fixed) ;; The other choice is auto, which causes trouble for me.
; Prevent key def loop between auto-complete.
; (setq yas-fallback-behavior 'return-nil)
; wcf fix: M-x yas-minor-mode. Disable it.

;(load "~/wcfShells/emacsEls/nxhtml/autostart.el")
;	; html-toc.
;	(require 'html-toc) ;; nxhtml is needed.
;	; (load "~/shells/emacsEls/nxhtml/autostart.el") ;; for html-toc.
;	(add-hook 'html-mode-hook
;	 (lambda ()
;	; (define-key html-mode-map (kbd "<M-left>") 'sgml-skip-tag-backward)
;	 (define-key html-mode-map (kbd "C-c C-/") 'html-toc)
;	; (define-key html-mode-map (kbd "<M-right>") 'sgml-skip-tag-forward)
;	 )
;	) ; HTML-toc ends.
; Stop nxthml to mess with my background-color.
(setq-default mumamo-background-colors nil)
;; Workaround the annoying warnings:
; mumamo-per-buffer-local-vars): Already 'permanent-local t: buffer-file-name
; (when (and (equal emacs-major-version 24)
;            (equal emacs-minor-version 2))
(when (equal emacs-major-version 24)
  (eval-after-load "mumamo"
	'(setq mumamo-per-buffer-local-vars
		   (delq 'buffer-file-name mumamo-per-buffer-local-vars))))
; Turn off nxhtml validation.
; http://stackoverflow.com/questions/11247666/emacs-nxhtml-mode-memory-full
(setq rng-nxml-auto-validate-flag nil)

; ------ Json
(setq load-path (cons (expand-file-name "~/wcfShells/emacsEls/json") load-path))
(require 'json-mode)
(setq-default json-reformat:pretty-string? t) ; Note the last '?' in the varName.
(setq-default json-reformat:indent-width 2)

; ------ web-mode
(require 'web-mode)

; ------ indent-guide
(require 'indent-guide)
(indent-guide-global-mode)

; ------ window
(require 'frame-cmds)
(defun wcfSmallWindow ()
  "Change current frame to small size."
  (interactive)
  (setq default-frame-alist '(
    (top . 0) (left . 100)
    (width . 75) (height . 30)
    )
  )
)
(defun wcfMaxWindow ()
  "Change current frame to big size."
  (interactive)
  (maximize-frame)
)

;;;; general editing functionality
;(require 'complete)

