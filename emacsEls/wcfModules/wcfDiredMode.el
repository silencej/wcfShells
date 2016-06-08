
(require 'dired-details)
(dired-details-install)

;; Title shows the file path.
(setq frame-title-format
    '("%S" (buffer-file-name "%f"
        (dired-directory dired-directory "%b"))))
;; Disable copy file on drag-and-drop in dired mode.
(setq dired-dnd-protocol-alist nil)

;; Dired copy file path
;; https://lists.gnu.org/archive/html/help-gnu-emacs/2002-10/msg00556.html
(defun dired-copy-filename ()
  "push the path and filename of the file under the point to the kill ring"
  (interactive)
  (message "added %s to kill ring" (kill-new (dired-get-filename))))
;;And this will bind it to 'c' on entering dired
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "c" 'dired-copy-filename)))
;; NOTE: use 'w' (dired-copy-filename-as-kill) to copy only the filename without path, or copy several marked filenames.


(when (eq system-type 'windows-nt)

  ;; Type F9 to open file in Dired mode.
  (defun w32-browser (doc)
    (w32-shell-execute 1 doc))
  
; (eval-after-load "dired" '(define-key dired-mode-map [f9] (lambda () (interactive) (w32-browser (dired-replace-in-string "/" "\\" (dired-get-filename))))))
  (eval-after-load "dired"
    '(define-key dired-mode-map [f9] 
        (lambda ()
            (interactive)
            (w32-browser (dired-get-filename)))))

;;; Windows explorer to open current file - Arun Ravindran
  (defun explorer ()
    "Launch the windows explorer in the current directory and selects current file"
	(interactive)
	(w32-shell-execute
     "open"
     "explorer"
  ;	(concat "/e,/select," (convert-standard-filename buffer-file-name))
     (concat "/e,/select," (convert-standard-filename default-directory))))

  (defun cmd ()
    "Launch the windows cmd in the current directory"
	(interactive)
	(w32-shell-execute
     "open"
     "cmd"
     ;;(concat "/e,/select," (convert-standard-filename buffer-file-name))
     ))

    ;(global-set-key (kbd "F12") 'explorer)        ; F12 - Open Explorer for the current file path
    ;(define-key dired-mode-map (kbd ""))

)
