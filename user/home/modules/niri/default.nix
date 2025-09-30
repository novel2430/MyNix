{ pkgs, lib, opt-config, ... }:
{
  home.file.".config/niri/waybar.jsonc".source = ./waybar.jsonc;
  home.file.".config/niri/waybar.css".source = ./waybar.css;
  home.file.".config/niri/config.kdl".source = ./config.kdl;
  home.file.".config/niri/niri-rofi-window-switcher.py".source = ./niri-rofi-window-switcher.py;
  home.packages = with pkgs; [
    niri 
    xwayland-satellite
  ];
}
