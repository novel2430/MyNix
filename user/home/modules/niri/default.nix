{ pkgs, lib, opt-config, ... }:
{
  home.file.".config/niri/waybar.jsonc".source = ./waybar.jsonc;
  home.file.".config/niri/waybar.css".source = ./waybar.css;
  home.packages = with pkgs; [
    niri 
    xwayland-satellite
  ];
}
