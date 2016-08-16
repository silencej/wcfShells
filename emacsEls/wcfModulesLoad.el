;; Aim: automatically loads all el files under "wcfModules" directory.

(setq load-path (cons "~/wcfShells/emacsEls" load-path))
(setq load-path (cons "~/wcfShells/emacsEls/smartparens" load-path))

(setq elFiles (directory-files "~/wcfShells/emacsEls/wcfModules" t ".+\.el$"))
(while elFiles
    (load-file (car elFiles))
    (setq elFiles (cdr elFiles))
)

; (directory-files "."
;     t
;     ".+\.el$")
