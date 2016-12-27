
; References:
; https://lorefnon.me/2014/02/02/configuring-emacs-for-rails.html

(use-package flymake-ruby
	:config
	(add-hook 'ruby-mode-hook 'flymake-ruby-load)
)

(use-package ruby-mode
	:config
	(setq ruby-deep-indent-paren nil)
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
