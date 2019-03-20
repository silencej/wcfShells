;;; init-42-coding-web.el --- Coding for web development

;; Copyright (C) 2016 Gregory J Stein

;; Author: Gregory J Stein <gregory.j.stein@gmail.com>
;; Maintainer: Gregory J Stein <gregory.j.stein@gmail.com>
;; Created: 20 Aug 2015

;; Keywords: configuration, html, web-mode, emmet
;; Homepage: https://github.com/gjstein/emacs.d
;; License: GNU General Public License (see init.el for details)

;;; Commentary:
;; Tools for programming web apps. This consists of:
;;   web-mode :: excellent syntax highlighting/indentation for html
;;            :: also includes support for css, js, django, etc.
;;   emmet :: code expansion for html/css

;;; Code:

;; == web-mode ==
(use-package web-mode
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.xml?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode)) ;; auto-enable for .js/.jsx files
  (add-to-list 'auto-mode-alist '("\\.es6$" . web-mode))
  (setq web-mode-engines-alist '(("django" . "\\.html\\'")))
	(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'") ("jsx" . "\\.es6\\'")))
	(setq web-mode-ac-sources-alist
		'(("css" . (ac-source-css-property))
		  ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
	(setq web-mode-enable-auto-closing t) ; Type </ will automatically close for you.
  (setq web-mode-enable-auto-quoting t) ; does the automatic quote insert.
  
  (defun my-web-mode-hook ()
    "Hooks for Web mode."
    (setq indent-tabs-mode nil)
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-enable-current-element-highlight t)
    )
  (add-hook 'web-mode-hook  'my-web-mode-hook)
)

(use-package emmet-mode
  :ensure t
  :defer t
  :init
	(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
	(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
	(add-hook 'web-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
	; By default, inserted markup will be indented with indent-region, according to the buffer's mode. To disable this
	; (add-hook 'emmet-mode-hook (lambda () (setq emmet-indent-after-insert nil)))
	(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces.
	; the cursor to be positioned between first empty quotes after expanding:
	(setq emmet-move-cursor-between-quotes t) ;; default nil
	; if you don't want to move cursor after expanding:
	; (setq emmet-move-cursor-after-expanding nil) ;; default t
	; If you want to use emmet with react-js's JSX, you probably want emmet to expand 'className="..."' instead of 'class="..."':
	(setq emmet-expand-jsx-className? t) ;; default nil
)

;---------- tide
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
	:mode (("\\.tsx\\'" . web-mode)
				("\\.ts\\'" . web-mode))
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
; Disable tide-format-before-save and add hooks for e.g. prettier-js-mode
; It should respect a tsfmt.json though
;         (before-save . tide-format-before-save)
	 )
)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
;; formats the buffer before saving
; (add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; TSX
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;; enable typescript-tslint checker
; (flycheck-add-mode 'typescript-tslint 'web-mode)

; (use-package jsx-mode
;   :defer t
;   :init
;   (add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
;   (autoload 'jsx-mode "jsx-mode" "JSX mode" t)
; )

;; == emmet ==
(use-package emmet-mode
  :ensure t
  :defer t
  :diminish emmet-mode
  :init
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
  (add-hook 'web-mode-hook 'emmet-mode)
  )

;; HTML

; http://ergoemacs.org/emacs/emacs_html.html
(defun wcfReplaceHtml-chars-region (start end)
	"Replace “<” to “&lt;” and other chars in HTML. This works on the current region."
	(interactive "r")
	(save-restriction
	(narrow-to-region start end)
	(goto-char (point-min))
	(while (search-forward "&" nil t) (replace-match "&amp;" nil t))
	(goto-char (point-min))
	(while (search-forward "<" nil t) (replace-match "&lt;" nil t))
	(goto-char (point-min))
	(while (search-forward ">" nil t) (replace-match "&gt;" nil t))
	)
)
(defun wcfRestoreHtml-chars-region (start end)
	"Replace “&lt;” to “<” and other chars in HTML. This works on the current region."
	(interactive "r")
	(save-restriction
	(narrow-to-region start end)
	(goto-char (point-min))
	(while (search-forward "&amp;" nil t) (replace-match "&" nil t))
	(goto-char (point-min))
	(while (search-forward "&lt;" nil t) (replace-match "<" nil t))
	(goto-char (point-min))
	(while (search-forward "&gt;" nil t) (replace-match ">" nil t))
	)
)

(use-package coffee-mode)

;; Make inserting code bring no newlines.
(add-hook 'html-mode-hook
	(lambda()
		(add-to-list 'html-tag-alist '("code"))
		(add-to-list 'html-tag-alist '("pre"))
		; Disable html autoview.
		(html-autoview-mode -1)
		(setq-local skeleton-end-newline nil) ; Suppress html-mode auto-indent. By setting this, for example "C-c RET" before some text will never append a newline and reindent.
	)
)
(customize-set-variable 'sgml-basic-offset 0)

(defun wcfInsertNoteHead ()
	"Insert notes' head."
	(interactive)
	(goto-char (point-min))
	(insert "<!-- -*- mode:html; -*- -->")
)

(defun wcfHtmlOccur ()
	"List all html headers in occur buffer."
	(interactive)
	; (occur "\\(<h[1-6]>.*</h[1-6]>\\)\\|\\(<article>\\)")
	(occur "^<h[1-6]>.*</h[1-6]>\\|^<article>")
)
; (global-set-key (kbd "<f7>") nil)
; (global-set-key (kbd "<f7> s") nil)
; (global-set-key (kbd "<f7> s o") 'wcfHtmlOccur)
(bind-key* "<f7> h o" 'wcfHtmlOccur)

(defun wcfPhpHtmlEntities ()
	"Insert php string and convert it with html entities."
	(interactive)
	(insert "<?php
$str=<<<'EOT'

EOT;
echo htmlspecialchars($str);
?>"
	)
)

; (global-set-key (kbd "<f7> p") nil)
; (global-set-key (kbd "<f7>-p h") 'wcfPhpHtmlEntities)
(bind-key* "<f7> p h" 'wcfPhpHtmlEntities 'html-mode)

; (use-package html-mode
; 	:ensure nil
; 	:bind-keymap* (
; 		("<f7> s o" . wcfHtmlOccur)
; 		("<f7> p h" . wcfPhpHtmlEntities)
; 	)
; )

