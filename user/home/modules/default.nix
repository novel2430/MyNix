{lib, opt-config, modify-pkgs, ...}:
{
  imports = [
    ./ssh
    ./git
    ./bash
    ./brave
    ./zsh
    ./fcitx5
    ./wayfire
    ./theme
    ./foot
    ./dunst
    ./wofi
    ./neovim
    ./tmux
    ./mimetype
    ./fzf
    ./fonts
    ./scripts
    ./river
    ./openbox
    ./sxhkd
    ./polybar
    ./rofi
    ./alacritty
    ./tint2
    ./pics
    ./mpv
    ./qutebrowser
  ]
  ;
}