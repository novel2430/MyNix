;;; config/treesitter.el -*- lexical-binding: t; -*-

(use-package! tree-sitter
  :hook ((
    bash-mode       ; Sh
    c-mode          ; C
    c++-mode        ; C++
    python-mode     ; Python
    json-mode       ; JSON
    yaml-mode       ; YAML
    nix-mode        ; Nix config
    lua-mode
    js2-mode
    java-mode
    ) 
  . tree-sitter-mode)
  :config
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package! tree-sitter-langs
  :config
  (setq tree-sitter-langs-grammar-alist
        '((c) (cpp) (python) (bash) (json) (yaml) (nix)))
  (unless (file-exists-p (tree-sitter-langs--bin-dir))
    (tree-sitter-langs-install-grammars)))
