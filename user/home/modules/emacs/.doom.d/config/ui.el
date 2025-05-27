
;; Font
(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 20))
;; Backup Font
(setq doom-unicode-font (font-spec :family "Noto Sans CJK TC"))

(setq display-line-numbers-type 'relative)
;; Display Line Number in all file
(global-display-line-numbers-mode 1)

;; Display Time
(display-time-mode 0)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;; modeline
(load! "custom-modeline.el")

;; theme
(load! "theme/theme.el")

;; Text Wrap
(global-visual-line-mode 1)
(add-hook! 'xref--xref-buffer-mode-hook
  (visual-line-mode 1)) ; 自动换行（推荐）
(setq word-wrap t)

(after! consult
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))




;; Transparent
(set-frame-parameter (selected-frame) 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))
