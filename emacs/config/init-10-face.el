(require 'use-package)

(use-package markdown-mode
    :demand)

;; Splash Screen to Org-mode
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'gfm-mode)

;; == Load Custom Theme ==

;;; Zenburn
;;(use-package zenburn-theme
;;  :ensure t
;;  :config (load-theme 'zenburn t)
;;  )

; ;;; Solarized
; (use-package color-theme :ensure t)
; (use-package color-theme-solarized
;   :ensure t
;   :init (load-theme 'solarized t)
;   )

;; I prefer using a smaller font size than the default (and 'Monaco')
(cond
  ((eq system-type 'darwin)
    (custom-set-faces '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Monaco"))))))
  ;; Evaluate the following when the others have errors loading and make color, font and themes absurd.
  (t
    (custom-set-faces '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 130 :width normal))))))
  ; (custom-set-faces '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "nil" :family "Ubuntu Mono"))))))
)

(global-linum-mode t) ; M-x linum-mode

;;-- GUI
;; When there is window system, in case -nw is not used.
(when window-system

    (setq default-frame-alist '( 
		(top . 0) (left . 100)
	;	(width . 75) (height . (/ (* 30 (display-pixel-height) ) 768) )
		(width . 75) (height . 30)
		)
	)
	
	(modify-frame-parameters nil '((wait-for-wm . nil))) ;; make font displaying faster.

	(custom-set-variables
	 ;; custom-set-variables was added by Custom.
	 ;; If you edit it by hand, you could mess it up, so be careful.
	 ;; Your init file should contain only one such instance.
	 ;; If there is more than one, they won't work right.
	 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
	 '(custom-enabled-themes (quote (manoj-dark)))
	 ; '(ede-project-directories (quote ("e:/itk" "e:/itk/Modules")))
	 '(size-indication-mode t))

  (scroll-bar-mode -1)

  ;(set-fontset-font nil 'utf-8 '"Microsoft Yahei")
  ;(set-face-attribute 'default nil :family "Consolas")
  ;; Set fallback fontset for unicode chars.
  (set-fontset-font "fontset-default" 'unicode
  					"Microsoft YaHei" nil 'prepend)
)
(unless window-system
	(setq-default linum-format "%3d\u2502")
)


;; Set default fill column
(setq-default fill-column 80)

(setq visible-bell t) ;turn off annoying beep.
(setq ring-bell-function 'ignore)
(setq scroll-preserve-screen-position t) ;; smooth scrolling

(display-time-mode t)
(column-number-mode t)
(when (fboundp 'size-indication-mode) (size-indication-mode t)) ;indicate the buffer size, in case that you delete blocks by mistake and cannot notice the damn fatal mistake. fboundp returns ture if the function symbol size-indication-mode is defined, false if undefined. Emacs 21 and 22.


;; Disable menu bars, etc.
(tool-bar-mode -1)
(menu-bar-mode -1)

;; No Backup Files
(setq make-backup-files nil)

(add-hook 'before-save-hook 'time-stamp)

(setq delete-by-moving-to-trash t) ; Making deleted files go to the trash can.

;; Encoding.
(setq default-enable-multibyte-characters t)
(setq ansi-color-for-comint-mode t)
; We recommend to use utf-8 always, for cross-platform. If you use gb18030 on Windows but utf-8 elsewhere, the file will have problems for git- file change only because of encoding switching.
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)

;; Fastfood
(fset 'yes-or-no-p 'y-or-n-p) ;make the y or n suffice for a yes or no question.


;; Tabs to spaces and tab width
(setq-default indent-tabs-mode nil)
(setq indent-tabs-width 2)
(setq default-tab-width 2)
;(define-key text-mode-map (kbd "TAB") 'self-insert-command) ; only in text-mode, pressing TAB will not indent apropriately but insert TAB.
;; Reset these so it indents like in VS.

; Make 'C-x C-f' completion case-sensitive.
(setq read-file-name-completion-ignore-case nil)
(setq-default truncate-lines nil)

;; Eye candy.
(transient-mark-mode t) ;highlight the active region.
(show-paren-mode t)
;(setq default-input-method nil) ;avoid chinese input method when init emacs.
(font-lock-mode t) ; syntax highlighted.

; ;;; copy rectangle
; (defun kill-rectangle-save (start end)
;	"Save the region-rectangle as the last killed one."
;	(interactive "r")
;	(require 'rect)				; Make sure killed-rectangle is defvar'ed.
;	(setq killed-rectangle (extract-rectangle start end))
;	(message "Rectangle saved")
; )

;; text mode, autoinserts and write hooks
(setq default-major-mode 'gfm-mode)

;(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'write-file-hooks 'copyright-update)
;(add-hook 'write-file-hooks 'delete-trailing-whitespace)
(setq ispell-program-name "aspell") ; ispell program.
(auto-image-file-mode 1) ; autoimage
;; shell-command completion
;(shell-command-activate-advices)
(setq shell-command-enable-completions t)

;(setq sentence-end "[.?!][]\"')]*\\($\\|\t\\| \\)[ \t\n]*") ;the default.
;(setq sentence-end "[.?!\),][]\"')]*\\($\\|\t\\| \\)*[ \t\n]*\\|[。，；？！）][］”’）]*[$\t ]*[ \t\n]*")
(setq sentence-end "[.?!,][]\"')]*\\($\\|\t\\| \\)[ \t\n]*\\|[。，；？！）][］”’）]*[$\t ]*[ \t\n]*")
(setq sentence-end-double-space nil) ; SENTENCES separated by just one space

;(define-key c-mode-map (kbd "C-c c") 'compile)
;(define-key c-mode-map (kbd "C-c n") 'next-error)

;(global-set-key "-." 'dirs) ; C-q C-c to insert Ctrl character.
;Strings can't contain non-ASCII control characters. Use (kbd "C-.") or
;[?\C-.] etc instead.

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Bookmark.
(setq bookmark-save-flag 1)
(setq bookmark-default-file "~/.emacs.bmk")
; 这会把书签保存到~/.emacs.bmk
; One more thing, perhaps, if you didn't know. Once you've typed the path after C-x C-f you can then use:
; C-x C-f M-p or M-n to navigate the history of the files you've opened up and down.
; C-x C-f M-r to search the history by providing it with regular expression (one downside though, you won't see the match it is going to make while you type the regexp). 

(use-package undo-tree
;; "M-x byte-compile-file" from within emacs.
;; If you want to replace the standard Emacs' undo system with the
;; `undo-tree-mode' system in all buffers, you can enable it globally by
;; adding:
    :demand
    :config (global-undo-tree-mode)
)

