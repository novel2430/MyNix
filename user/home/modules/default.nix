{opt-config, lib, ...}:
{
  imports = [
    ./ssh
    ./git
    ./bash
    ./zsh
    ./fcitx5
    ./theme
    ./dunst
    ./neovim
    ./tmux
    ./mimetype
    ./fzf
    ./fonts
    ./scripts
    ./pics
    ./mpv
    ./qutebrowser
    ./brave
  ]
  ++ 
  lib.optionals (opt-config.wm.wayfire) [
    ./wayfire
  ]
  ++ 
  lib.optionals (opt-config.wm.river) [
    ./river
  ]
  ++ 
  lib.optionals (opt-config.wm.river || opt-config.wm.wayfire) [
    ./wofi
    ./foot 
  ]
  ++ 
  lib.optionals (opt-config.wm.openbox) [
    ./picom
    ./sxhkd
    ./polybar
    ./rofi
    ./alacritty
    ./tint2
    ./openbox
  ]
  ;
}
