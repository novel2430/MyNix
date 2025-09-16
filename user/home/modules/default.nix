{opt-config, lib, custom-pkgs, ...}:
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
    ./scripts
    ./pics
    ./mpv
    # ./qutebrowser
    ./fastfetch
    ./maven
    # ./alacritty
    ./wezterm
    # ./emacs
    # ./direnv
    ./rofi
  ]
  ++ 
  lib.optionals (opt-config.wm.awesome) [
    ./awesome
  ]
  ++ 
  lib.optionals (opt-config.wm.labwc) [
    ./labwc
  ]
  ++ 
  lib.optionals (opt-config.wm.dwl) [
    ./dwl
  ]
  ++ 
  lib.optionals (opt-config.wm.dwm) [
    ./dwm
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
  lib.optionals (opt-config.wm.river || opt-config.wm.wayfire || opt-config.wm.dwl || opt-config.wm.labwc) [
    ./wofi
    ./foot 
  ]
  ++ 
  lib.optionals (opt-config.wm.awesome || opt-config.wm.dwm ) [
    ./greenclip
    ./picom
    ./sxhkd
  ]
  ;
}
