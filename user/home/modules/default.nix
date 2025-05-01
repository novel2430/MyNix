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
    ./openbox-theme
    ./zellij
    ./fastfetch
    ./maven
    # ./ghostty
    # ./kitty
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
  lib.optionals (opt-config.wm.labwc) [
    ./labwc
  ]
  ++ 
  lib.optionals (opt-config.wm.river || opt-config.wm.wayfire || opt-config.wm.labwc) [
    ./wofi
    ./foot 
    ./fuzzel
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
