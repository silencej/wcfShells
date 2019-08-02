(require 'use-package)

;; == Evil Mode ==
; wcfNote: disabled because of error: tar-mode not found.
; (use-package evil-leader
;   :ensure t
;   :init
;   (global-evil-leader-mode)
;   (evil-leader/set-leader ",")
;   (evil-leader/set-key "c" 'org-capture)
;   (evil-leader/set-key "a" 'org-agenda)
;   (evil-leader/set-key "g" 'magit-status)
;   )
; 
; (use-package evil
;   :ensure t
;   :init
;   (evil-mode 1)
;   (define-key evil-ex-map "b " 'helm-mini)
;   (define-key evil-ex-map "e" 'helm-find-files)
;   ;; Resolve sentence jumping issue
;   (setq sentence-end-double-space nil)
;   )


;; == Helm Mode ==
(use-package helm
  :ensure t
  :diminish helm-mode
  :init

  ;; Changes the helm prefix key
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))

  ;; Supress warning
  (setq ad-redefinition-action 'accept)

  :config

  (require 'helm)
  (require 'helm-files)
  (require 'helm-config) ; Necessary for helm-mode
  
  ;; Additional key bindings
  (bind-key "<tab>" 'helm-execute-persistent-action helm-map)
  (bind-key [escape] 'helm-keyboard-quit helm-map)
  (bind-key "C-l" (kbd "RET") helm-map)

  (setq helm-split-window-in-side-p           t
	helm-move-to-line-cycle-in-source     t
	helm-ff-search-library-in-sexp        t
	helm-scroll-amount                    8
	helm-M-x-fuzzy-match                  t
	helm-ff-file-name-history-use-recentf t)


  (if (string-equal system-type "darwin")
      ;; This requires the 'ggrep' command to be installed for OSX
      (setq helm-grep-default-command
	    "ggrep --color=always -d skip %e -n%cH -e %p %f"
	    helm-grep-default-recurse-command
	    "ggrep --color=always -d recurse %e -n%cH -e %p %f"))
  (if (string-equal system-type "gnu/linux")
      (setq helm-grep-default-command
	    "grep --color=always -d skip %e -n%cH -e %p %f"
	    helm-grep-default-recurse-command
	    "grep --color=always -d recurse %e -n%cH -e %p %f"))

  (helm-mode 1)

  (defun spacemacs//hide-cursor-in-helm-buffer ()
    "Hide the cursor in helm buffers."
    (with-helm-buffer
      (setq cursor-in-non-selected-windows nil)))
  (add-hook 'helm-after-initialize-hook 'spacemacs//hide-cursor-in-helm-buffer)
  
  :bind (("C-x b" . helm-mini)
	 ("C-x C-f" . helm-find-files)
	 ("M-x" . helm-M-x)
	 :map helm-map
	 ("C-i" . helm-execute-persistent-action)
	 ("C-z" . helm-select-action)
	 ("C-j" . helm-next-line)
	 ("C-k" . helm-previous-line)
	 ("C-h" . helm-next-source)
	 ("C-S-h" . describe-key)
	 :map helm-find-files-map
	 ("C-l" . helm-execute-persistent-action)
	 ("C-h" . helm-find-files-up-one-level)
	 :map helm-read-file-map
	 ("C-l" . helm-execute-persistent-action)
	 ("C-h" . helm-find-files-up-one-level)
	 )
)

(use-package helm-swoop
  :config
  ;; Change the keybinds to whatever you like :)
  ; (global-set-key (kbd "M-i") 'helm-swoop)
  ; (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
  ; (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
  ; (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
  
  ;; When doing isearch, hand the word over to helm-swoop
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
  ;; From helm-swoop to helm-multi-swoop-all
  (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
  ;; When doing evil-search, hand the word over to helm-swoop
  ;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)
  
  ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
  (define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)
  
  ;; Move up and down like isearch
  (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
  (define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)
  
  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t)
  
  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows nil)
  
  ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
  (setq helm-swoop-split-direction 'split-window-vertically)
  
  ;; If nil, you can slightly boost invoke speed in exchange for text color
  (setq helm-swoop-speed-or-color nil)
  
  ;; ;; Go to the opposite side of line from the end or beginning of line
  (setq helm-swoop-move-to-line-cycle t)
  
  ;; Optional face for line numbers
  ;; Face name is `helm-swoop-line-number-face`
  (setq helm-swoop-use-line-number-face t)
  
  ;; If you prefer fuzzy matching
  (setq helm-swoop-use-fuzzy-match t)
  
  ;; If you would like to use migemo, enable helm's migemo feature
  ; migemo: an Emacs package that provides Japanese increment search with ‘Romanization of Japanese’(ローマ字).
  ; (helm-migemo-mode 1)
)

; (use-package migemo
;   :ensure t)

(use-package quelpa-use-package
  :ensure t
  :init
  (setq quelpa-update-melpa-p nil)
  (setq quelpa-self-upgrade-p nil))

; Use the code from emacsWiki since melpa no longer supports it
(let ((bookmarkplus-dir "~/.emacs.d/custom/bookmark-plus/")
              (emacswiki-base "https://www.emacswiki.org/emacs/download/")
              (bookmark-files '("bookmark+.el" "bookmark+-mac.el" "bookmark+-bmu.el" "bookmark+-key.el" "bookmark+-lit.el" "bookmark+-1.el")))
          (require 'url)
          (add-to-list 'load-path bookmarkplus-dir)
          (make-directory bookmarkplus-dir t)
          (mapcar (lambda (arg)
                    (let ((local-file (concat bookmarkplus-dir arg)))
                      (unless (file-exists-p local-file)
                        (url-copy-file (concat emacswiki-base arg) local-file t))))
                    bookmark-files)
          (byte-recompile-directory bookmarkplus-dir 0)
          (require 'bookmark+))

; (use-package bookmark+
;   :ensure t
;   :config
; 	(setq bookmark-version-control t)
; 	(setq delete-old-versions t)
; ;	:load-path "~/wcfShells/emacs/packages/bookmark-plus"
; )
