{ pkgs, lib, opt-config, ... }:
{
  home.file.".config/hypr/waybar.jsonc".source = ./waybar.jsonc;
  home.packages = with pkgs; [
    grim
    slurp
    hyprpicker
    hyprland
    xwayland
  ];

  imports = [
    ./hyprland-conf.nix
    ./waybar.nix
  ];
}
