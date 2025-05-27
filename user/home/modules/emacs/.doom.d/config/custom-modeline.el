(setq doom-modeline-height 25)
(setq doom-modeline-bar-width 4)
(setq doom-modeline-project-detection 'auto)
(setq doom-modeline-buffer-file-name-style 'auto)
(setq doom-modeline-icon nil)

(with-eval-after-load 'doom-modeline
  (doom-modeline-def-modeline 'main
    '(bar major-mode modals buffer-info)
    '(selection-info check buffer-position " "))
  (setq doom-modeline-mode-alist nil)

  (add-hook 'after-change-major-mode-hook
            (lambda ()
              (doom-modeline-set-modeline 'main 'default)))

  (add-hook 'doom-modeline-mode-hook
            (lambda ()
              (doom-modeline-set-modeline 'main 'default))))

