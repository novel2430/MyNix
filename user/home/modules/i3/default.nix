{ config, pkgs, custom-pkgs, lib, opt-config, ... }:
let
  betterlockscreen = "${pkgs.betterlockscreen}/bin/betterlockscreen";
  feh = "${pkgs.feh}/bin/feh";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  gsettings = "${pkgs.glib}/bin/gsettings";
  blutooth-cmd = if opt-config.bluetooth then "${pkgs.blueman}/bin/blueman-applet &" else "";
  dunst = "${pkgs.dunst}/bin/dunst";
  xset = "${pkgs.xorg.xset}/bin/xset";
  greenclip = "${pkgs.haskellPackages.greenclip}/bin/greenclip";
  sxhkd = "${pkgs.sxhkd}/bin/sxhkd";
  polybar-i3 = pkgs.polybar.override { i3Support = true; };
  polybar = "${polybar-i3}/bin/polybar";
in
{

  home.file.".config/i3/config".source = ./config;
  home.file.".config/i3/config.ini".source = ./config.ini;
  home.file.".config/i3/bat.py".source = ./bat.py;
  home.file.".config/i3/temp.py".source = ./temp.py;
  home.file.".config/i3/autostart.sh" = {
    executable = true;
    text = ''
      start-wm X11
      # Lock Screen
      ${betterlockscreen} -u ${opt-config.lock-img} --fx && ${pkgs.dunst}/bin/dunstify "Better Lock Screen" "Done!" &
      # Bar
      ${polybar} -c /home/${opt-config.username}/.config/i3/config.ini &
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
      ${xset} s off
      ${xset} s noblank
      ${xset} -dpms
      # xdg-portal
      (
        unset WAYLAND_DISPLAY
        env XDG_CURRENT_DESKTOP=dwm \
          dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP
      )
      systemctl --user stop xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-wlr
      systemctl --user restart pipewire pipewire-pulse wireplumber
      systemctl --user start xdg-desktop-portal-gtk
      systemctl --user start xdg-desktop-portal
      # Greenclip
      ${greenclip} daemon &
      # Blueman-applet
      ${blutooth-cmd}
      # Xsetroot cursor
      xsetroot -cursor_name left_ptr
      # SXHKD
      ${sxhkd} &
      # Media Idle Guard
      systemctl --user stop media-idle-guard.service
      systemctl --user start media-idle-guard.service
      # For Wemeet
      flatpak override --user --unset-env=LD_PRELOAD com.tencent.wemeet &
    '';
  };

  home.packages = [
    pkgs.i3
  ];
}
