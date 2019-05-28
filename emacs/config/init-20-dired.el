; (use-package dired-details+
; 	:config
; 	(dired-details-install)
; 
;   ;; Title shows the file path.
;   (setq frame-title-format
;       '("%S" (buffer-file-name "%f"
;           (dired-directory dired-directory "%b"))))
;   ;; Disable copy file on drag-and-drop in dired mode.
;   (setq dired-dnd-protocol-alist nil)
;   
;   ;; Dired copy file path
;   ;; https://lists.gnu.org/archive/html/help-gnu-emacs/2002-10/msg00556.html
;   (defun dired-copy-filename ()
;     "push the path and filename of the file under the point to the kill ring"
;     (interactive)
;     (message "added %s to kill ring" (kill-new (dired-get-filename))))
;   ;;And this will bind it to 'c' on entering dired
;   (add-hook 'dired-mode-hook
;             (lambda ()
;               (define-key dired-mode-map "c" 'dired-copy-filename)))
;   ;; NOTE: use 'w' (dired-copy-filename-as-kill) to copy only the filename without path, or copy several marked filenames.
; 	)

; revert each Dired buffer automatically when you revisit it
(custom-set-variables
 '(dired-auto-revert-buffer 1))

; https://emacs.stackexchange.com/questions/24459/revert-all-open-buffers-and-ignore-errors
(defun wcf/revert-all-file-buffers ()
  "Refresh all open file buffers without confirmation.
Buffers in modified (not yet saved) state in emacs will not be reverted. They
will be reverted though if they were modified outside emacs.
Buffers visiting files which do not exist any more or are no longer readable
will be killed."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      ;; Revert only buffers containing files, which are not modified;
      ;; do not try to revert non-file buffers like *Messages*.
      (when (and filename
                 (not (buffer-modified-p buf)))
        (if (file-readable-p filename)
            ;; If the file exists and is readable, revert the buffer.
            (with-current-buffer buf
              (revert-buffer :ignore-auto :noconfirm :preserve-modes))
          ;; Otherwise, kill the buffer.
          (let (kill-buffer-query-functions) ; No query done when killing buffer
            (kill-buffer buf)
            (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finished reverting buffers containing unmodified files."))


