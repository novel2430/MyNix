{pkgs, opt-config, ...}:
let
  swaybg = "${pkgs.swaybg}/bin/swaybg";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
  cliphist = "${pkgs.unstable.cliphist}/bin/cliphist";
  gsettings = "${pkgs.glib}/bin/gsettings";
in
{
  home.packages = [
    (import ./waybar.nix {
      inherit pkgs;
    })
    pkgs.labwc
  ];
  home.file.".config/labwc/rc.xml".source = ./rc.xml;
  home.file.".config/labwc/menu.xml".source = ./menu.xml;
  home.file.".config/labwc/environment" = {
    source = ./env;
    executable = true;
  };
  home.file.".config/labwc/waybar.jsonc".source = ./waybar.jsonc;
  home.file.".config/labwc/waybar.css".source = ./waybar.css;

  home.file.".config/labwc/autostart" = {
    text = ''
      start-wm $WAYLAND_DISPLAY
      # Wallpaper
      ${swaybg} -i ${opt-config.wall-img} -m fill &
      # bar
      labwc-waybar &
      # nm-applet
      ${nm-applet} &
      # Clipboard <cliphist>
      ${wl-paste} --watch ${cliphist} store &
      # GTK title bar layout
      # ${gsettings} set org.gnome.desktop.wm.preferences button-layout ':minimize,maximize,close'
      # GRT Dark Theme (fix for GTK4)
      ${gsettings} set org.gnome.desktop.interface color-scheme 'prefer-dark'
      # Bluetooth (Blueman)
      # systemctl --user restart dbus-org.bluez.obex.service 
      # systemctl --user restart blueman-applet.service 
      # xdg-portal
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
      systemctl --user start pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
      # Swayidle
      my-swayidle &
      # IME
      fcitx5 --replace -d &
    '';
    executable = true;
  };
}
