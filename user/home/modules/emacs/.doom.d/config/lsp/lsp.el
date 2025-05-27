(setq lsp-diagnostics-provider :auto)
(setq lsp-enable-links nil)
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil)
)
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
(add-hook 'python-mode-hook
  (lambda ()
    (run-at-time
     "5 sec" nil
     (lambda ()
       (lsp-semantic-tokens-mode 1)))))
(add-hook 'lua-mode-hook
  (lambda ()
    (run-at-time
     "5 sec" nil
     (lambda ()
       (lsp-semantic-tokens-mode 1)))))
(add-hook 'js2-mode-hook
  (lambda ()
    (run-at-time
     "5 sec" nil
     (lambda ()
       (lsp-semantic-tokens-mode 1)))))

(load! "pyright.el")
(load! "clangd.el")
(load! "lua.el")
(load! "vue.el")
(load! "jdtls.el")

