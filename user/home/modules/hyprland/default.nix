{ pkgs, lib, opt-config, ... }:
{
  home.file.".config/hypr/waybar.jsonc".source = ./waybar.jsonc;
  home.file.".config/hypr/waybar.css".source = ./waybar.css;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.packages = with pkgs; [
    grim
    slurp
    hyprpicker
    hyprland
    xwayland
  ];

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };
}
