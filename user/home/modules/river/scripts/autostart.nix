{pkgs, opt-config, ...}:
let
  swaybg = "${pkgs.swaybg}/bin/swaybg";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
  cliphist = "${pkgs.unstable.cliphist}/bin/cliphist";
  gsettings = "${pkgs.glib}/bin/gsettings";
  blutooth-cmd = if opt-config.bluetooth then "${pkgs.blueman}/bin/blueman-applet &" else "";
in
pkgs.writeShellScriptBin "my-river-autostart" ''
  start-wm $WAYLAND_DISPLAY
  # Wallpaper
  ${swaybg} -i ${opt-config.wall-img} -m fill &
  # AGS
  #novel-ags &
  # bar
  river-waybar &
  # Clipboard <cliphist>
  ${wl-paste} --watch ${cliphist} store &
  # GTK title bar layout
  # ${gsettings} set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
  # GRT Dark Theme (fix for GTK4)
  ${gsettings} set org.gnome.desktop.interface color-scheme 'prefer-dark'
  # xdg-portal
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
  systemctl --user start pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
  # Swayidle
  my-swayidle &
  # IME
  fcitx5 --replace -d &
  # Blueman-applet
  ${blutooth-cmd}
  # nm-applet
  ${nm-applet} &
  # Media Idle Guard
  systemctl --user stop media-idle-guard.service
  systemctl --user start media-idle-guard.service

''
