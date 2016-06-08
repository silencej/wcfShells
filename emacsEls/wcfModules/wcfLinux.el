;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keyword: linuxSet
;; Linux
(when (eq system-type 'gnu/linux)

(require 'multi-term)
(setq multi-term-program "/bin/bash")
;(setq term-unbind-key-list '())
;(setq term-bind-key-alist '(()))
; (global-set-key [?\C-,] (lambda () (interactive) (term "/bin/bash"))) ; C-,
) ; Linux endos.
