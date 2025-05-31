(after! lsp-mode
  (setq lsp-volar-take-over-mode t))

;; Add LSP Semantic Highlight
(add-hook 'js2-mode-hook
  (lambda ()
    (run-at-time
     "5 sec" nil
     (lambda ()
       (lsp-semantic-tokens-mode 1)))))

