;;; init-40-coding-gen.el --- Code for general programming

;; Copyright (C) 2016 Gregory J Stein

;; Author: Gregory J Stein <gregory.j.stein@gmail.com>
;; Maintainer: Gregory J Stein <gregory.j.stein@gmail.com>
;; Created: 20 Aug 2015

;; Keywords: configuration, company, magit, git, flycheck
;; Homepage: https://github.com/gjstein/emacs.d
;; License: GNU General Public License (see init.el for details)

;;; Commentary:
;; General tools for programming across languages.  This consists of:
;;   Company :: used for code completion
;;   Projectile :: used for searching projects
;;   Magit :: used for interfacing with git/github
;;   Flycheck :: code syntax/convention checking

;;; Code:

; ;; == org mode source code syntax highlighting
; (use-package slime)
; (org-babel-do-load-languages
;  'org-babel-load-languages '(
; 		(C . t)
; 		(lisp . t)
; ))

;; === Code Completion ===

;; == company-mode ==
(use-package company
  :ensure t
  :defer t
  :diminish company-mode
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (use-package company-irony :ensure t :defer t)
;  (setq company-idle-delay              nil
;	company-minimum-prefix-length   2
;	company-show-numbers            t
;	company-tooltip-limit           20
;	company-dabbrev-downcase        nil
;	)
)

;; === Tools ===

(use-package htmlize
  :ensure t
  :defer t
)

(use-package plantuml-mode
  :ensure t
  :defer t
  :config (progn
		(setq org-plantuml-jar-path (expand-file-name "~/wcfShells/support/plantuml.1.2020.2.jar"))
		(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
    (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
	)
)

;; == YASnippet ==
(use-package yasnippet
  :ensure t
  :defer t
  :config (yas-global-mode t)
  )

;; == Projectile ==
(use-package projectile
  :ensure t
  :defer t
  :init
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (use-package helm-projectile
    :ensure t
    :init
    (helm-projectile-on)
    )
  )
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; == ag ==

;; Note that 'ag' (the silver searcher) needs to be installed.
;; Ubuntu: sudo apt-get install ag
;; OSX: brew install ag
(use-package ag
  :ensure t
  )

(use-package helm-ag
  :ensure t
  )

;; == compile ==

(use-package php-mode
  :ensure t
  :defer t
)

;; https://emacs.stackexchange.com/questions/8135/why-does-compilation-buffer-show-control-characters
(use-package ansi-color
  :ensure t
  :config (progn
            (defun my/ansi-colorize-buffer ()
              (let ((buffer-read-only nil))
                (ansi-color-apply-on-region (point-min) (point-max))))
            (add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)))

;; == magit ==
(use-package magit
  :ensure t
  :defer t
  :bind ("C-x g" . magit-status)
  :init
  (setq magit-diff-options (quote ("--word-diff")))
  (setq magit-diff-refine-hunk 'all)
  (setq magit-refresh-verbose t)
;  ;; Use evil keybindings within magit
;  (use-package evil-magit
;    :ensure t
;    :config
;    ;; Default commit editor opening in insert mode
;    (add-hook 'with-editor-mode-hook 'evil-insert-state)
;    (evil-define-key 'normal with-editor-mode-map
;      (kbd "RET") 'with-editor-finish
;      [escape] 'with-editor-cancel
;      )
;    (evil-define-key 'normal git-rebase-mode-map
;      "l" 'git-rebase-show-commit
;    )
;  )
)

(use-package magit-lfs
  :ensure t
  :defer t
)

;; == flycheck ==
(use-package flycheck
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  ;; check OS type
  (if (string-equal system-type "gnu/linux")
      (progn
	(custom-set-variables
	 '(flycheck-c/c++-clang-executable "clang-3.5")
	 )))
  (add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++11")))
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-gcc))
  ; Stop checking for lisp doc format.
  ; https://emacs.stackexchange.com/questions/21664/how-to-prevent-flycheck-from-treating-my-init-el-as-a-package-file
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
)

;; == OTHER LANGUAGES ==

(use-package swift-mode
  :ensure t
  :defer t
  )

;---------- gopls

; https://github.com/golang/tools/blob/master/gopls/doc/emacs.md

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Optional - provides fancier overlays.
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :ensure t
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

;;; init-40-coding-gen.el ends here
