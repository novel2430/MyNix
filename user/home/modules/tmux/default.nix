{ pkgs, ... }:
{
  # Tmux
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 5000;
    keyMode = "vi";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
    extraConfig = ''
      # Basic
      set -g prefix C-x
      unbind-key C-b
      set -g pane-base-index 1
      set -g renumber-window on
      set-option -g detach-on-destroy off
      set -g @mode_hint ""
      set-option -ga status-left ' #[fg=yellow]#{@mode_hint} '
      set -g history-limit 10000

      # Normal Mode
      bind j next-window 
      bind k previous-window 

      # Window Mode
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      # Split Mode
      bind S run-shell "tmux set -g @mode_hint ''; tmux switch-client -T split-mode"
      bind -T split-mode q run-shell "tmux set -g @mode_hint \"\"; tmux switch-client -T root"
      bind -T split-mode Escape run-shell "tmux set -g @mode_hint \"\"; tmux switch-client -T root"
      bind -T split-mode Any run-shell "tmux switch-client -T split-mode"
      bind -T split-mode h run-shell "tmux split-window -h; tmux switch-client -T split-mode"
      bind -T split-mode v run-shell "tmux split-window -v; tmux switch-client -T split-mode"
      bind -T split-mode j run-shell "tmux select-pane -t :.+; tmux switch-client -T split-mode"
      bind -T split-mode k run-shell "tmux select-pane -t :.-; tmux switch-client -T split-mode"
      bind -T split-mode Left run-shell "tmux resize-pane -L 3; tmux switch-client -T split-mode"
      bind -T split-mode Right run-shell "tmux resize-pane -R 3; tmux switch-client -T split-mode"
      bind -T split-mode Up run-shell "tmux resize-pane -U 2; tmux switch-client -T split-mode"
      bind -T split-mode Down run-shell "tmux resize-pane -D 2; tmux switch-client -T split-mode"
      bind -T split-mode J run-shell "tmux swap-pane -U; tmux switch-client -T split-mode"
      bind -T split-mode K run-shell "tmux swap-pane -D; tmux switch-client -T split-mode"
      bind -T split-mode d run-shell "tmux kill-pane; tmux switch-client -T split-mode"

      # Session Mode
      bind s run-shell 'tmux set -g @mode_hint "󰿡"; tmux switch-client -T session-mode;'
      bind -T session-mode q run-shell "tmux set -g @mode_hint \"\"; tmux switch-client -T root"
      bind -T session-mode Escape run-shell "tmux set -g @mode_hint \"\"; tmux switch-client -T root"
      bind -T session-mode Enter run-shell "tmux set -g @mode_hint \"\"; tmux switch-client -T root"
      bind -T session-mode Any run-shell "tmux switch-client -T session-mode"
      bind -T session-mode j run-shell 'tmux switch-client -n; tmux switch-client -T session-mode;'
      bind -T session-mode k run-shell 'tmux switch-client -p; tmux switch-client -T session-mode;'
      bind -T session-mode b run-shell 'tmux switch-client -l; tmux switch-client -T session-mode;'
      bind -T session-mode r command-prompt -I "#S" -p "Rename session to:" "run-shell '
        tmux rename-session \"%%\";
        tmux switch-client -T session-mode;
      '"
      bind -T session-mode n command-prompt -p "New Session:" "run-shell '
        tmux new-session -d -s \"%%\"; 
        tmux switch-client -n; 
        tmux set -g @mode_hint \"\"; 
        tmux switch-client -T root;
      '" 
      bind -T session-mode d run-shell "
        tmux kill-session; 
        tmux set -g @mode_hint \"\"; 
        tmux switch-client -T root;
      "
      bind -T session-mode f run-shell "tmux choose-tree -s; tmux set -g @mode_hint \"\"; tmux switch-client -T root"

      # Copy Mode
      bind x run-shell 'tmux set -g @mode_hint "󰆏"; tmux copy-mode;'
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi V send -X select-line
      bind -T copy-mode-vi C-v send -X select-block
      bind -T copy-mode-vi y send -X copy-selection
      bind -T copy-mode-vi q send -X clear-selection
      bind -T copy-mode-vi Escape run-shell "tmux set -g @mode_hint \"\"; tmux send-keys -X cancel"
    '';
    plugins = with pkgs.tmuxPlugins; [
      nord 
    ];
  };
}
