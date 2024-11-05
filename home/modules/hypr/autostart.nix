{pkgs, opt-config, ...}:
let
  swaybg = "${pkgs.swaybg}/bin/swaybg";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
  cliphist = "${pkgs.unstable.cliphist}/bin/cliphist";
  gsettings = "${pkgs.glib}/bin/gsettings";
  wlopm = "${pkgs.wlopm}/bin/wlopm";
in
pkgs.writeShellScriptBin "my-hpyr-autostart" ''
  # Close eDP-1
  # ${wlopm} --off eDP-1 
  # Wallpaper
  ${swaybg} -i ${opt-config.wall-img} -m fill &
  # bar
  my-hypr-run-waybar &
  # nm-applet
  ${nm-applet} &
  # Clipboard <cliphist>
  ${wl-paste} --watch ${cliphist} store &
  # GTK title bar layout
  ${gsettings} set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
  # GRT Dark Theme (fix for GTK4)
  ${gsettings} set org.gnome.desktop.interface color-scheme 'prefer-dark'
  # Bluetooth (Blueman)
  # systemctl --user restart dbus-org.bluez.obex.service 
  # systemctl --user restart blueman-applet.service 
  # xdg-portal
  # dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  # systemctl --user stop pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
  # systemctl --user start pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
  # Mihomo (Clash)
  #systemctl --user restart clash.service
  # IME
  fcitx5 --replace -d &
  # SwayIdle
  my-swayidle
''
