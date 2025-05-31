(setq lsp-diagnostics-provider :auto)
(setq lsp-enable-links nil)
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil)
)

(load! "pyright.el")
(load! "clangd.el")
(load! "lua.el")
(load! "vue.el")
(load! "jdtls.el")

