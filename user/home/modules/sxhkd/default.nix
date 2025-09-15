{pkgs, custom-pkgs, ...}:
let
  app = {
    browser = "${custom-pkgs.zen-browser}/bin/zen-browser";
    lock = "x-lock";
    clipboard = "greenclip-rofi";
    screenshot = "maim-screenshot full";
    screenshot-select = "maim-screenshot select";
    powermenu = "rofi-power-menu";
    volume-mute = "my-volume mute";
    volume-up = "my-volume up";
    volume-down = "my-volume down";
    brightness-up = "${pkgs.brightnessctl}/bin/brightnessctl set 10%+";
    brightness-down = "${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
    playerctl-playpause = "${pkgs.playerctl}/bin/playerctl play-pause";
    playerctl-next = "${pkgs.playerctl}/bin/playerctl next";
    playerctl-prev = "${pkgs.playerctl}/bin/playerctl previous";
  };
in
{
  services.sxhkd = {
    enable = true;
    keybindings = {
      # Browser
      "spuer + shift + f" = "${app.browser}";
      # Lock
      "spuer + shift + l" = "${app.lock}";
      # Clipboard
      "spuer + c" = "${app.clipboard}";
      # Screenshot
      "Print" = "${app.screenshot}";
      "super + Print" = "${app.screenshot-select}";
      # Powermenu
      "spuer + shift + p" = "${app.powermenu}";
      # Volume
      "XF86AudioRaiseVolume" = "${app.volume-up}";
      "XF86AudioLowerVolume" = "${app.volume-down}";
      "XF86AudioMute" = "${app.volume-mute}";
      # Brightness
      "XF86MonBrightnessUp" = "${app.brightness-up}";
      "XF86MonBrightnessDown" = "${app.brightness-down}";
      # Playerctl
      "XF86AudioPlay" = "${app.playerctl-playpause}";
      "XF86AudioNext" = "${app.playerctl-next}";
      "XF86AudioPrev" = "${app.playerctl-prev}";
    };
  };
}
