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

(defun my/main-vterm-open ()
  "Toggle a vterm buffer named <main-vterm>"
  (interactive)
  (let ((buf (get-buffer "main-vterm")))
    (if buf
        (switch-to-buffer buf)
      (let ((vterm-buffer (generate-new-buffer "*main-vterm-temp*")))
        (with-current-buffer vterm-buffer
          (vterm-mode)
          (rename-buffer "main-vterm" t))
        (switch-to-buffer "main-vterm")))))

(defun my/spotify-open ()
  "Toggle a vterm buffer named <spotify> and run ncspot."
  (interactive)
  (let ((buf (get-buffer "spotify")))
    (if buf
        (switch-to-buffer buf)
      (let ((vterm-buffer (generate-new-buffer "*spotify-temp*")))
        (with-current-buffer vterm-buffer
          (vterm-mode)
          (rename-buffer "spotify" t)
          (run-with-timer
           0.1 nil
           (lambda ()
             (when (buffer-live-p (get-buffer "spotify"))
               (with-current-buffer "spotify"
                 (vterm-send-string "ncspot")
                 (vterm-send-return))))))
        (switch-to-buffer "spotify")))))

(defun my/spotify-play-pause ()
  "ncspot play/pause"
  (interactive)
  (if (get-buffer "spotify")
      (progn (set-buffer "spotify")
             (vterm-send-string "P"))))

(defun my/spotify-play-next ()
  "ncspot play next"
  (interactive)
  (if (get-buffer "spotify")
      (progn (set-buffer "spotify")
             (vterm-send-string ">"))))

(defun my/spotify-play-previous ()
  "ncspot play previous"
  (interactive)
  (if (get-buffer "spotify")
      (progn (set-buffer "spotify")
             (vterm-send-string "<"))))


(map! :leader
      :desc "Toggle vterm"
      "t" #'+vterm/toggle)
(map! :leader
      :desc "Toggle main-vterm"
      "T" #'my/main-vterm-open)
(map! :leader
      :desc "Spit Window horizontal (below)"
      "w s" #'evil-window-split)
(map! :leader
      :desc "Spit Window vertical (right)"
      "w v" #'evil-window-vsplit)

(map! :leader
      :desc "Find in current Buffer"
      "f n" #'consult-line)
(map! :leader
      :desc "Find Buffer in current Workspace"
      "f b" #'+vertico/switch-workspace-buffer)
(map! :leader
      :desc "Find Buffer in current Project"
      "f p" #'project-find-file)
(map! :leader
      :desc "Find File"
      "f f" #'find-file)

(map! :leader
      :desc "Open a Spotify(ncspot) buffer"
      "m o" #'my/spotify-open)
(map! :leader
      :desc "Toggle Spotify(ncspot) play/pause"
      "m p" #'my/spotify-play-pause)
(map! :leader
      :desc "Play Next Song Spotify(ncspot)"
      "m >" #'my/spotify-play-next)
(map! :leader
      :desc "Play Previous Song Spotify(ncspot)"
      "m <" #'my/spotify-play-previous)
(map!
  ;; Insert mode
  ;;;; Save and Leave
  :i "C-s" 
    (cmd! (save-some-buffers t)
      (evil-normal-state))
  ;;;; Leave
  :i "C-]"
    (cmd! (evil-normal-state))
  ;;;; For LSP Bridge
  ;; :i "C-j" #'acm-select-next
  ;; :i "C-k" #'acm-select-prev

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
  :n "gd" #'+lookup/definition
  :n "gs" #'consult-eglot-symbols
  :n "gD" #'+lookup/diagnostics
  :n "gf" #'eglot-format-buffer
  :n "gr" #'+lookup/references
  :n "gI" #'+lookup/implementations
  :n "gt" #'+lookup/type-definition
  :n "K"  #'lsp-describe-thing-at-point
  ;; :n "K"  #'+lookup/documentation
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

