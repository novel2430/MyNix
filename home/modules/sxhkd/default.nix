{pkgs, ...}:
{
  home.file.".config/sxhkd/sxhkdrc" = {
    text = with pkgs; ''
      #
      # My Hotkeys
      #

      # Reload
      super + shift + r
        killall ${sxhkd}/bin/sxhkd; ${sxhkd}/bin/sxhkd &

      # Rofi
      super + d
        ${rofi}/bin/rofi -show drun
      super + r
        ${rofi}/bin/rofi -show run
      # Brave
      super + shift + f
        brave
      # Reload PolyBar
      super + shift + b
        killall ${polybar}/bin/polybar; ${polybar}/bin/polybar &
      # volume up
      XF86AudioRaiseVolume
        my-volume up
      # volume down
      XF86AudioLowerVolume
        my-volume down
      # volume mute
      XF86AudioMute
        my-volume mute
      # screenshot full
      Print
        scrot-screenshot full
      # screenshot select
      super + Print
        scrot-screenshot select
    '';
  };
  home.packages = [
    pkgs.sxhkd
  ];
}
