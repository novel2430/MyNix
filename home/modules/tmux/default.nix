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
      set -g pane-base-index 1
      set -g renumber-window on
    '';
    plugins = with pkgs.tmuxPlugins; [
      nord 
    ];
  };
}
