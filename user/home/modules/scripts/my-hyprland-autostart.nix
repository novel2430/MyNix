{pkgs, opt-config, ...}:
let
  swaybg = "${pkgs.swaybg}/bin/swaybg";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
  cliphist = "${pkgs.unstable.cliphist}/bin/cliphist";
  gsettings = "${pkgs.glib}/bin/gsettings";
  blutooth-cmd = if opt-config.bluetooth then "${pkgs.blueman}/bin/blueman-applet &" else "";
  dunst = "${pkgs.dunst}/bin/dunst";
  waybar = "${pkgs.waybar}/bin/waybar";
in
pkgs.writeShellScriptBin "my-hyprland-autostart" ''
  start-wm $WAYLAND_DISPLAY
  # Wallpaper
  ${swaybg} -i ${opt-config.wall-img} -m fill &
  # Notify
  ${dunst} &
  # Clipboard <cliphist>
  ${wl-paste} --watch ${cliphist} store &
  # Bar
  ${waybar} -c /home/${opt-config.username}/.config/hypr/waybar.jsonc -s /home/${opt-config.username}/.config/hypr/waybar.css &
  # GRT Dark Theme (fix for GTK4)
  ${gsettings} set org.gnome.desktop.interface color-scheme 'prefer-dark'
  # xdg-portal
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk xdg-desktop-portal-gnome xdg-desktop-portal-hyprland
  systemctl --user start pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-wlr
  # IME
  fcitx5 --replace -d &
  # Blueman-applet
  ${blutooth-cmd}
  # nm-applet
  ${nm-applet} &
  # Media Idle Guard
  systemctl --user stop media-idle-guard.service
  systemctl --user start media-idle-guard.service
  # For Wemeet
  flatpak override --user --env=LD_PRELOAD=/app/lib/wemeet/libhook.so com.tencent.wemeet &
''
