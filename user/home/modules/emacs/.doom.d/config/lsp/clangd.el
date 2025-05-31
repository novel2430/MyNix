(after! lsp-ui
  (setq lsp-clients-clangd-executable "clangd")
  (setq lsp-disabled-clients '(ccls)))

;; Add LSP Semantic Highlight
(add-hook 'c-mode-hook
  (lambda ()
    (run-at-time
     "5 sec" nil
     (lambda ()
       (lsp-semantic-tokens-mode 1)))))
(add-hook 'c++-mode-hook
  (lambda ()
    (run-at-time
     "5 sec" nil
     (lambda ()
       (lsp-semantic-tokens-mode 1)))))
