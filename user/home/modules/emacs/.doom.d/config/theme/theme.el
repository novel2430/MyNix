;; theme
;; (setq doom-theme 'doom-xcode)
;; (setq doom-theme 'doom-miramare)
;; (after! doom-themes
;;   (custom-set-faces!
;;     '(default :background "#2E3440")
;;     '(hl-line :background "#3B4252")
;;     '(line-number :foreground "#4C566A")
;;     '(line-number-current-line :foreground "#D8DEE9" :weight bold)
;;     '(region :background "#434C5E")
;;     '(mode-line :background "#3B4252" :foreground "#E5E9F0" :box nil)
;;     '(mode-line-inactive :background "#2E3440" :foreground "#4C566A" :box nil)
;;     '(minibuffer-prompt :foreground "#81A1C1" :weight bold)
;;     '(vertico-current :background "#3B4252" :foreground "#ECEFF4" :weight bold)
;;   )
;; )

(add-to-list 'custom-theme-load-path "~/.doom.d/config/theme")
(setq doom-theme 'doom-vscode)
