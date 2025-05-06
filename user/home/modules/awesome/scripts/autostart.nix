{pkgs, opt-config, ...}:
let
  betterlockscreen = "${pkgs.betterlockscreen}/bin/betterlockscreen";
  feh = "${pkgs.feh}/bin/feh";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  gsettings = "${pkgs.glib}/bin/gsettings";
  blutooth-cmd = if opt-config.bluetooth then "${pkgs.blueman}/bin/blueman-applet &" else "";
  dunst = "${pkgs.dunst}/bin/dunst";
  xset = "${pkgs.xorg.xset}/bin/xset";
  xautolock = "${pkgs.xautolock}/bin/xautolock";
  greenclip = "${pkgs.haskellPackages.greenclip}/bin/greenclip";
  picom = "${pkgs.picom}/bin/picom";
in
pkgs.writeShellScriptBin "my-awesome-autostart" ''
  start-wm X11
  # Lock Screen
  ${betterlockscreen} -u ${opt-config.lock-img} --fx && ${pkgs.dunst}/bin/dunstify "Better Lock Screen" "Done!" &
  # Dunst
  ${dunst} &
  # Wallpaper
  ${feh} --bg-fill ${opt-config.wall-img} &
  # Keyboard speed rate (xset)
  ${xset} r rate 300 50
  # GRT Dark Theme (fix for GTK4)
  ${gsettings} set org.gnome.desktop.interface color-scheme 'prefer-dark'
  # Fcitx
  fcitx5 --replace -d &
  # nm-applet
  ${nm-applet} &
  # Idle DPMS (sec)
  ${xset} dpms 1800 3600 3600 
  # Idle Lock Screen (min)
  ${xautolock} -time 60 -locker "x-lock" &
  # xdg-portal
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY="" XDG_CURRENT_DESKTOP=awesome
  # Greenclip
  ${greenclip} daemon &
  # Picom
  ${picom} &
  # Blueman-applet
  ${blutooth-cmd}
''
