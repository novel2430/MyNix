;;; doom-vscode-theme.el --- A custom VSCode-inspired theme -*- lexical-binding: t; no-byte-compile: t; -*-

(require 'doom-themes)

(defgroup doom-vscode-theme nil
  "Options for the `doom-vscode' theme."
  :group 'doom-themes)

(defcustom doom-vscode-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds padding to the modeline. Can be an integer."
  :group 'doom-vscode-theme
  :type '(choice integer boolean))

(def-doom-theme doom-vscode
  "A dark theme based on VSCode color palette."

  ;; Color palette
  (
   (bg         '("#2e3440" nil nil))
   (bg-alt     '("#2e3440" nil nil))
   (base0      '("#3b4252"))
   (base1      '("#465780"))
   (base2      '("#2e3440"))
   (base3      '("#3b4252"))
   (base4      '("#465780"))
   (base5      '("#88c0d0"))
   (base6      '("#93ccdc"))
   (base7      '("#e5e9f0"))
   (base8      '("#e7ecf4"))
   (fg         '("#cdcecf"))
   (fg-alt     '("#e5e9f0"))

   (black      '("#1e1e1e"))
   (grey       '("#808080"))
   (red        '("#F44747"))
   (light-red  '("#D16969"))
   (orange     '("#CE9178"))
   (yellow-orange '("#D7BA7D"))
   (green      '("#6A9955"))
   (blue-green '("#4EC9B0"))
   (light-green '("#B5CEA8"))
   (yellow     '("#DCDCAA"))
   (dark-yellow '("#FFD602"))
   (blue       '("#569CD6"))
   (accent-blue '("#4FC1FF"))
   (medium-blue '("#18a2fe"))
   (disabled-blue '("#729DB3"))
   (light-blue '("#9CDCFE"))
   (dark-blue  '("#223E55"))
   (magenta    '("#C586C0"))
   (cyan       '("#4EC9B0"))
   (violet     '("#646695"))
   (teal       '("#4EC9B0"))
   (dark-cyan  '("#51504F"))
   (pink       '("#C586C0"))
   (nord-dark-blue '("#5e81ac"))
   (nord-dark-white '("#d8dee9"))

   ;; Face categories
   (highlight      blue)
   (vertical-bar   base1)
   (selection      '("#264F78"))
   (builtin        blue)
   (comments       green)
   (doc-comments   teal)
   (constants      blue)
   (functions      yellow)
   (keywords       pink)
   (methods        yellow)
   (operators      fg)
   (type           teal)
   (strings        orange)
   (variables      light-blue)
   (numbers        light-green)
   (region         '("#264F78"))
   (error          red)
   (warning        yellow-orange)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; Modeline
   (modeline-bg     base0)
   (modeline-bg-alt base0)
   (modeline-fg     fg)
   (modeline-fg-alt fg-alt)

   (-modeline-pad
    (when doom-vscode-padded-modeline
      (if (integerp doom-vscode-padded-modeline) doom-vscode-padded-modeline 4))))

  ;; Face overrides
  ((lazy-highlight :background base4 :foreground fg :weight 'bold)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-alt :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (tooltip :background black :foreground fg)

   (minibuffer-prompt :foreground blue :weight 'bold)
   (region :background region)
   (highlight :background selection)
   (hl-line :background black)

   ;; Tree-sitter (ts) face mapping (example)
   (tree-sitter-hl-face:embedded :foreground comments :slant 'italic)
   (tree-sitter-hl-face:comment :foreground comments :slant 'italic)
   (tree-sitter-hl-face:function :foreground functions)
   (tree-sitter-hl-face:function.builtin :foreground functions)
   (tree-sitter-hl-face:function.call :foreground functions)
   (tree-sitter-hl-face:function.macro :foreground pink :weight 'bold)
   (tree-sitter-hl-face:function.method :foreground functions)
   (tree-sitter-hl-face:function.special :foreground functions)
   (tree-sitter-hl-face:keyword :foreground keywords :weight 'bold)
   (tree-sitter-hl-face:constant :foreground constants :weight 'bold)
   (tree-sitter-hl-face:constant.builtin :foreground constants :weight 'bold)
   (tree-sitter-hl-face:number :foreground numbers)
   (tree-sitter-hl-face:string :foreground strings)
   (tree-sitter-hl-face:type :foreground type)
   (tree-sitter-hl-face:property :foreground variables)
   (tree-sitter-hl-face:operator :foreground fg)
   (tree-sitter-hl-face:punctuation :foreground fg)
   (tree-sitter-hl-face:attribute :foreground yellow)
   (tree-sitter-hl-face:variable :foreground variables)
   (tree-sitter-hl-face:variable.parameter :foreground variables)
   (tree-sitter-hl-face:variable.member :foreground variables)
   (tree-sitter-hl-face:variable.builtin :foreground variables)
   (tree-sitter-hl-face:variable.global :foreground variables)
   (tree-sitter-hl-face:variable.static :foreground variables)
   (tree-sitter-hl-face:variable.special :foreground variables)
   (tree-sitter-hl-face:keyword.conditional :foreground pink :weight 'bold)
   (tree-sitter-hl-face:keyword.repeat :foreground pink :weight 'bold)
   (tree-sitter-hl-face:keyword.return :foreground pink :weight 'bold)
   (tree-sitter-hl-face:keyword.exception :foreground pink :weight 'bold)
   (tree-sitter-hl-face:keyword.import :foreground pink :weight 'bold)
   (tree-sitter-hl-face:label :foreground variables)

   ;; LSP
   (lsp-face-semhl-macro :foreground blue :weight 'bold)
   (lsp-face-semhl-variable :foreground variables)
   (lsp-face-semhl-parameter :foreground variables)
   (lsp-face-semhl-function :foreground functions)
   (lsp-face-semhl-definition :inherit nil)
   (lsp-face-semhl-keyword :inherit nil)
   (lsp-face-semhl-static :foreground constants :weight 'bold)
   (lsp-face-semhl-constant :inherit nil)
   (lsp-face-semhl-property :foreground variables)
   (lsp-face-semhl-operator :foreground fg)

   ;; Web
   (web-mode-html-tag-face           :foreground blue)
   (web-mode-html-attr-name-face     :foreground light-blue)
   (web-mode-html-attr-value-face    :foreground orange)
   (web-mode-doctype-face            :foreground grey)
   (web-mode-comment-face            :foreground green)
   (web-mode-block-delimiter-face    :foreground pink)
   (web-mode-function-call-face      :foreground light-blue)
   (web-mode-keyword-face            :foreground pink)
   (web-mode-string-face             :foreground orange)
   (web-mode-variable-name-face      :foreground light-blue)
   (web-mode-type-face               :foreground blue-green)
   (web-mode-constant-face           :foreground blue)

   ;; js2
   (js2-object-property-access :foreground variables)

   ;; Corfu
   (corfu-current :background nord-dark-blue :foreground fg :weight 'bold) ;; Select
   (corfu-default :background base0 :foreground fg)               ;; Normal
   (corfu-border :background fg)                                      ;; Border
   (corfu-annotations :foreground nord-dark-white :slant 'italic)

   ;; Line numbers
   (line-number :foreground grey)
   (line-number-current-line :foreground fg :weight 'bold)

   ;; Org-mode
   ((org-block &override) :background base1)
   ((org-block-background &override) :background base1)
   ((org-block-begin-line &override) :background base2))

  ;; Variables
  ())

(provide-theme 'doom-vscode)
;;; doom-vscode-theme.el ends here

(defun my/disable-lsp-interface-face ()
  "Disable the lsp-face-semhl-interface face in current buffer."
  (add-to-list 'face-remapping-alist
               '(lsp-face-semhl-interface :inherit nil)))

(dolist (hook '(c-mode-hook
                c++-mode-hook
                python-mode-hook
                lua-mode-hook
                nix-mode-hook))
  (add-hook hook #'my/disable-lsp-interface-face))

