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
      ${dunst}/bin/dunst &
      ${sxhkd}/bin/sxhkd &
      ${xorg.xset}/bin/xset r rate 300 50
      ${feh}/bin/feh --bg-fill ${opt-config.wall-img}
      ${networkmanagerapplet}/bin/nm-applet &
      killall ${polybar}/bin/polybar; ${polybar}/bin/polybar &
      killall ${tint2}/bin/tint2; ${tint2}/bin/tint2 &
      # GTK title bar layout
      #${pkgs.glib}/bin/gsettings set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
      # GRT Dark Theme (fix for GTK4)
      #${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      fcitx5 --replace -d &
    '';
    executable = true;
  };
  home.file.".local/share/themes" = {
    source = ./themes;
    recursive = true;
  };
  
  
  
  home.packages = [
    pkgs.openbox
  ];
}
