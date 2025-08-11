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
    # ./fonts
    ./scripts
    ./pics
    ./mpv
    # ./qutebrowser
    ./fastfetch
    ./maven
    # ./awesome
    ./alacritty
    ./rofi
    ./greenclip
    ./picom
    ./wezterm
    # ./emacs
    # ./direnv
    ./dwl
    # ./labwc

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
  lib.optionals (opt-config.wm.river || opt-config.wm.wayfire) [
    ./wofi
    ./foot 
  ]
  ;
}
