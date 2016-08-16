
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

