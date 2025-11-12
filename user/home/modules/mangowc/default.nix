{ config, pkgs, custom-pkgs, lib, opt-config, ... }:
let
  dunst = "${pkgs.dunst}/bin/dunst";
  swaybg = "${pkgs.swaybg}/bin/swaybg";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
  cliphist = "${pkgs.unstable.cliphist}/bin/cliphist";
  gsettings = "${pkgs.glib}/bin/gsettings";
  blutooth-cmd = if opt-config.bluetooth then "${pkgs.blueman}/bin/blueman-applet &" else "";
  waybar = "${pkgs.waybar}/bin/waybar";
in
{

  home.file.".config/mango/config.conf".source = ./config.conf;
  home.file.".config/mango/waybar.jsonc".source = ./waybar.jsonc;
  home.file.".config/mango/waybar.css".source = ./waybar.css;
  home.file.".config/mango/autostart.sh" = {
    executable = true;
    text = ''
      start-wm $WAYLAND_DISPLAY
      # Wallpaper
      ${swaybg} -i ${opt-config.wall-img} -m fill &
      # Bar
      ${waybar} -c /home/${opt-config.username}/.config/mango/waybar.jsonc -s /home/${opt-config.username}/.config/mango/waybar.css &
      # Dunst
      ${dunst} &
      # Clipboard <cliphist>
      ${wl-paste} --watch ${cliphist} store &
      # GRT Dark Theme (fix for GTK4)
      ${gsettings} set org.gnome.desktop.interface color-scheme 'prefer-dark'
      # Fcitx
      fcitx5 --replace -d &
      # nm-applet
      ${nm-applet} &
      # xdg-portal
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
      systemctl --user stop pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk xdg-desktop-portal-gnome
      systemctl --user start pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
      # Blueman-applet
      ${blutooth-cmd}
      # Media Idle Guard
      systemctl --user stop media-idle-guard.service
      systemctl --user start media-idle-guard.service
      # For Wemeet
      flatpak override --user --unset-env=LD_PRELOAD com.tencent.wemeet &
    '';
  };

  home.packages = [
    pkgs.nur.repos.novel2430.mangowc
  ];
}
