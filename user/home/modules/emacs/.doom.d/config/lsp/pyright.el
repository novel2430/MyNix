(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred
;; Add LSP Semantic Highlight
(add-hook 'python-mode-hook
  (lambda ()
    (run-at-time
     "5 sec" nil
     (lambda ()
       (lsp-semantic-tokens-mode 1)))))
