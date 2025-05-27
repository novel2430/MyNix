(use-package! drag-stuff
  :config
  (drag-stuff-global-mode 1))


(defun my/visual-indent-smart-right ()
  "Indent visual region based on visual mode type (RIGHT)."
  (interactive)
  (cond
   ((eq evil-visual-selection 'char)
    (drag-stuff-right 1) )
   ((eq evil-visual-selection 'line)
    (evil-shift-right (region-beginning) (region-end))
    (evil-visual-restore))))

(defun my/visual-indent-smart-left ()
  "Indent visual region based on visual mode type (RIGHT)."
  (interactive)
  (cond
   ((eq evil-visual-selection 'char)
    (drag-stuff-left 1) )
   ((eq evil-visual-selection 'line)
    (evil-shift-left (region-beginning) (region-end))
    (evil-visual-restore))))


(map! :leader
      :desc "Toggle vterm"
      "t" #'+vterm/toggle)
(map! :leader
      :desc "Open vterm in new Buffer"
      "T" #'+vterm/here)
(map! :leader
      :desc "Spit Window horizontal (below)"
      "w s" #'evil-window-split)
(map! :leader
      :desc "Spit Window vertical (right)"
      "w v" #'evil-window-vsplit)
(map!
  ;; Insert mode
  ;;;; Save and Leave
  :i "C-s" 
    (cmd! (save-some-buffers t)
      (evil-normal-state))
  ;;;; Leave
  :i "C-]"
    (cmd! (evil-normal-state))

  ;; Normal mode 
  :n "C-s" (cmd! (save-some-buffers t))
  ;;;; Leave
  :n "C-]"
    (cmd! (evil-normal-state))
  ;;;; Buffers
  :n "H" #'previous-buffer
  :n "L" #'next-buffer
  ;;;; Comment
  :n "C-\\" #'comment-line
  ;;;; LSP
  :n "gd" #'lsp-find-definition
  :n "gs" #'consult-lsp-file-symbols
  :n "gD" #'consult-lsp-diagnostics
  :n "gf" #'lsp-format-buffer
  :n "gr" #'lsp-find-references
  :n "gI" #'lsp-find-implementation
  :n "gt" #'lsp-find-type-definition
  :n "K"  #'lsp-describe-thing-at-point
  ;;;; Finding Stuff
  :n "fn"  #'consult-line
  :n "fb"  #'+vertico/switch-workspace-buffer
  :n "fpf" #'project-find-file
  :n "ff" #'find-file

  ;; Visual mode
  :v "C-s" #'save-some-buffers
  ;;;; Leave
  :v "C-]"
    (cmd! (evil-normal-state))
  ;;;; Move Left and Right
  :v "L" #'my/visual-indent-smart-right
  :v "H" #'my/visual-indent-smart-left
  :v ">" #'my/visual-indent-smart-right
  :v "<" #'my/visual-indent-smart-left
  ;;;; Move Up and Down
  :v "J" #'drag-stuff-down
  :v "K" #'drag-stuff-up
  ;;;; Comment
  :v "C-\\" #'comment-line

  ;; Emacs mode
  ;;:e "C-s" #'isearch-forward
)

