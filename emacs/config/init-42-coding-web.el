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
  (setq web-mode-engines-alist '(("django" . "\\.html\\'")))
  
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
		; Disable html autoview.
		(html-autoview-mode -1)
	)
)

(defun wcfInsertNoteHead ()
	"Insert notes' head."
	(interactive)
	(goto-char (point-min))
	(insert "<!-- -*- mode:html; -*- -->")
)

(defun wcfHtmlOccur ()
	"List all html headers in occur buffer."
	(interactive)
	(occur "\\(<h[1-6]>.*</h[1-6]>\\)\\|\\(<article>\\)")
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

