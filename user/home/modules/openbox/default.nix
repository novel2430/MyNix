{pkgs, opt-config, ...}:
{
  home.file.".config/openbox/rc.xml".source = ./rc.xml;
  home.file.".config/openbox/menu.xml".source = ./menu.xml;
  home.file.".config/openbox/environment" = {
    source = ./env;
    executable = true;
  };
  home.file.".config/openbox/autostart" = with pkgs; {
    text = ''
      start-wm X11
      # Update Lock Screen
      ${betterlockscreen}/bin/betterlockscreen -u ${opt-config.lock-img} &
      ${dunst}/bin/dunst &
      ${sxhkd}/bin/sxhkd &
      ${xorg.xset}/bin/xset r rate 300 50
      ${feh}/bin/feh --bg-fill ${opt-config.wall-img}
      ${networkmanagerapplet}/bin/nm-applet &
      killall ${polybar}/bin/polybar; ${polybar}/bin/polybar &
      killall ${tint2}/bin/tint2; ${tint2}/bin/tint2 &
      # GTK title bar layout
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
      # GRT Dark Theme (fix for GTK4)
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      # Idle
      ${xorg.xset}/bin/xset dpms 1800 1800 3600
      ${xss-lock}/bin/xss-lock -- x-lock &
      # ${pkgs.unstable.picom}/bin/picom &
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY=none XDG_CURRENT_DESKTOP=sway
      fcitx5 --replace -d &
    '';
    executable = true;
  };
  home.packages = [
    pkgs.openbox
  ];
}
