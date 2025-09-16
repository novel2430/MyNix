{pkgs, ...}:
let
  app = with pkgs; {
    browser = "${nur.repos.novel2430.zen-browser-bin}/bin/zen-browser";
    lock = "x-lock";
    clipboard = "greenclip-rofi";
    screenshot = "maim-screenshot full";
    screenshot-select = "maim-screenshot select";
    powermenu = "rofi-power-menu";
    volume-mute = "my-volume mute";
    volume-up = "my-volume up";
    volume-down = "my-volume down";
    brightness-up = "${brightnessctl}/bin/brightnessctl set 10%+";
    brightness-down = "${brightnessctl}/bin/brightnessctl set 10%-";
    playerctl-playpause = "${playerctl}/bin/playerctl play-pause";
    playerctl-next = "${playerctl}/bin/playerctl next";
    playerctl-prev = "${playerctl}/bin/playerctl previous";
    killall = "${psmisc}/bin/killall";
    sxhkd = "${sxhkd}/bin/sxhkd";
  };
in
{
  services.sxhkd = {
    enable = true;
    keybindings = with app; {
      # Browser
      "super + shift + f" = "${browser}";
      # Lock
      "super + shift + l" = "${lock}";
      # Clipboard
      "super + c" = "${clipboard}";
      # Clash Switcher
      "super + shift + c" = "clash-switcher";
      # Screenshot
      "Print" = "${screenshot}";
      "super + Print" = "${screenshot-select}";
      # Powermenu
      "super + shift + p" = "${powermenu}";
      # Volume
      "XF86AudioRaiseVolume" = "${volume-up}";
      "XF86AudioLowerVolume" = "${volume-down}";
      "XF86AudioMute" = "${volume-mute}";
      # Brightness
      "XF86MonBrightnessUp" = "${brightness-up}";
      "XF86MonBrightnessDown" = "${brightness-down}";
      # Playerctl
      "XF86AudioPlay" = "${playerctl-playpause}";
      "XF86AudioNext" = "${playerctl-next}";
      "XF86AudioPrev" = "${playerctl-prev}";
      # Reload Sxhkd
      "super + shift + r" = "${killall} -r sxhkd; ${sxhkd} &";
      # Reload Polybar
      "super + shift + b" = "${killall} -r polybar; dwm-polybar &";
    };
  };
}
