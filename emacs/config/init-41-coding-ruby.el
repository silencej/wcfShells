
; References:
; https://lorefnon.me/2014/02/02/configuring-emacs-for-rails.html

(use-package flymake-ruby
	:config
	(add-hook 'ruby-mode-hook 'flymake-ruby-load)
)

(use-package ruby-mode
	:config
	(setq ruby-deep-indent-paren nil)
	(add-hook 'ruby-mode-hook 'robe-mode)
	:bind* (
		("C-c r r" . inf-ruby) ; Ruby shell.
	)
)

(use-package rvm
	:bind* (
		("C-c r a" . rvm-activate-corresponding-ruby)
	)
)

(use-package projectile-rails
	:config
	(add-hook 'projectile-mode-hook 'projectile-rails-on)
	(add-hook 'ruby-mode-hook 'projectile-rails-on)
)

(use-package flx-ido
	:config
	;; Display ido results vertically, rather than horizontally
  (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
  (add-hook 'ido-setup-hook 'ido-define-keys)
)

(use-package company)

(use-package robe
	:config
	(add-hook 'ruby-mode-hook 'robe-mode)
	; instruct robe to auto-trigger rvm-activate-corresponding-ruby.
	(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
	  (rvm-activate-corresponding-ruby))

	(global-company-mode t)
	(push 'company-robe company-backends)
)
