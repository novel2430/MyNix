;;; config/lsp/lua.el -*- lexical-binding: t; -*-

(after! lsp-ui
  (setq lsp-lua-workspace-max-preload 2048 ; Default: 300, Max preloaded files
        lsp-lua-workspace-preload-file-size 4096; Default: 100, Skip files larger than this value (KB) when preloading.
  )
)
;; Add LSP Semantic Highlight
(add-hook 'lua-mode-hook
  (lambda ()
    (run-at-time
     "5 sec" nil
     (lambda ()
       (lsp-semantic-tokens-mode 1)))))
