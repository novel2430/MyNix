{ pkgs, lib, opt-config, ... }:
{
  home.file.".config/niri/waybar.jsonc".source = ./waybar.jsonc;
  home.file.".config/niri/niri-rofi-window-switcher.py".source = ./niri-rofi-window-switcher.py;
  home.file.".config/niri/waybar-modules-niri-ws-count.py".source = ./waybar-modules-niri-ws-count.py;
  home.packages = with pkgs; [
    niri 
    xwayland-satellite
  ];
  imports = [
    ./niri-config.nix
    ./waybar.nix
  ];
}
