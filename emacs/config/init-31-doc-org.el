;;; init-30-doc-org.el --- Code for initializing org-mode

;; Copyright (C) 2016 Gregory J Stein

;; Author: Gregory J Stein <gregory.j.stein@gmail.com>
;; Maintainer: Gregory J Stein <gregory.j.stein@gmail.com>
;; Created: 20 Aug 2015

;; Keywords: configuration, org
;; Homepage: https://github.com/gjstein/emacs.d
;; License: GNU General Public License (see init.el for details)

;;; Commentary:
;; Runs org-mode along with some custom configuration files
;;
;; More information can be found at:
;;    http://doc.norang.ca/org-mode.html

;;; Code:

(use-package org
  :init
  ; (add-hook 'org-mode-hook 'visual-line-mode)
  ; (add-hook 'org-mode-hook 'org-indent-mode)
  ; (add-hook 'org-mode-hook 'flyspell-mode) TODO: use hunspell on windows. https://lists.gnu.org/archive/html/help-gnu-emacs/2014-04/msg00030.html
    (add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

  :defer t
  :bind (("\C-c a" . org-agenda)
	 ("\C-c c" . org-capture))
  :config
  ;; Custom functions for emacs & org mode
  (load "gs-org")
  (add-to-list 'org-modules 'org-tempo t)

	; For exporting to odt, doc, etc
	; wcfNote: because of incompatibility of zip, odt export is still not working.
	; (setq org-odt-convert-process 'LibreOffice); 'unoconv) ; Need to install libreoffice, and add wcfShells/support to PATH
  ; (setq org-export-odt-preferred-output-format 'docx)

  ;; == Agenda ==
  (defvar org-agenda-window-setup)
  (setq org-agenda-window-setup 'current-window)
  
  ;; Run/highlight code using babel in org-mode
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (python . t)
     (octave . t)
     (C . t)
     ))
  ;; Syntax hilight in #+begin_src blocks
  (setq org-src-fontify-natively t)

  ; ;; Evil key configurations (agenda)
  ; (evil-set-initial-state 'org-agenda-mode 'normal)
  ; (defvar org-agenda-mode-map)
  ; (evil-define-key 'normal org-agenda-mode-map
  ;   "l" 'org-agenda-later
  ;   "h" 'org-agenda-earlier
  ;   "j" 'org-agenda-next-line
  ;   "k" 'org-agenda-previous-line
  ;   (kbd "RET") 'org-agenda-switch-to
  ;   [escape] 'org-agenda-quit
  ;   "q" 'org-agenda-quit
  ;   "s" 'org-agenda-save-all-org-buffers
  ;   "t" 'org-agenda-todo
  ;   (kbd "SPC") 'org-agenda-show-and-scroll-up
  ;   )
  ; (evil-leader/set-key-for-mode 'org-agenda-mode
  ;   "i" 'org-agenda-clock-in
  ;   "o" 'org-agenda-clock-out
  ;   "k" 'org-agenda-kill
  ;   "/" 'org-agenda-filter-by-tag
  ;   )
	; 
  ; ;; Evil key configuration (org)
  ; (evil-leader/set-key-for-mode 'org-mode
  ;   "i" 'org-clock-in
  ;   "o" 'org-clock-out
  ;   )
)

(custom-set-variables
 '(initial-major-mode 'org-mode) ; previously gfm-mode
 '(org-cycle-emulate-tab (quote white))
)

;;; init-31-doc-org.el ends here
