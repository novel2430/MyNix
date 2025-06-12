{pkgs, opt-config, ...}:
let
  swaybg = "${pkgs.swaybg}/bin/swaybg";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
  cliphist = "${pkgs.unstable.cliphist}/bin/cliphist";
  gsettings = "${pkgs.glib}/bin/gsettings";
  blutooth-cmd = if opt-config.bluetooth then "${pkgs.blueman}/bin/blueman-applet &" else "";
  wayland-pipewire-idle-inhibit = "${pkgs.wayland-pipewire-idle-inhibit}/bin/wayland-pipewire-idle-inhibit";
in
pkgs.writeShellScriptBin "my-wf-autostart" ''
  start-wm $WAYLAND_DISPLAY
  # AGS
  #novel-ags &
  ${pkgs.dunst}/bin/dunst &
  # Wallpaper
  ${swaybg} -i ${opt-config.wall-img} -m fill &
  # bar
  my-run-waybar &
  # nm-applet
  ${nm-applet} &
  # Clipboard <cliphist>
  ${wl-paste} --watch ${cliphist} store &
  # GTK title bar layout
  ${gsettings} set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
  # GRT Dark Theme (fix for GTK4)
  ${gsettings} set org.gnome.desktop.interface color-scheme 'prefer-dark'
  # xdg-portal
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
  systemctl --user start pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
  # IME
  fcitx5 --replace -d &
  # Blueman-applet
  #${blutooth-cmd}
  # Idle Inhibit
  ${wayland-pipewire-idle-inhibit} -w &
''
