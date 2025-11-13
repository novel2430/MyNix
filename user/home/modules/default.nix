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
    ./wezterm
    # ./emacs
    # ./direnv
    ./rofi
    ./yazi
  ]
  ++ 
  lib.optionals (opt-config.wm.openbox) [
    ./openbox
  ]
  ++ 
  lib.optionals (opt-config.wm.mangowc) [
    ./mangowc
  ]
  ++ 
  lib.optionals (opt-config.wm.sway) [
    ./sway
  ]
  ++ 
  lib.optionals (opt-config.wm.i3) [
    ./i3
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
  lib.optionals (opt-config.wm.niri) [
    ./niri
  ]
  ++ 
  lib.optionals (opt-config.wm.hypr) [
    ./hyprland
  ]
  ++ 
  lib.optionals (opt-config.wm.mangowc || opt-config.wm.sway || opt-config.wm.river || opt-config.wm.wayfire || opt-config.wm.dwl || opt-config.wm.labwc || opt-config.wm.niri || opt-config.wm.hypr) [
    ./foot 
  ]
  ++ 
  lib.optionals (opt-config.wm.openbox || opt-config.wm.awesome || opt-config.wm.dwm || opt-config.wm.i3 ) [
    ./greenclip
    ./picom
    ./sxhkd
  ]
  ;
}
