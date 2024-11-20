{ config, pkgs, lib, opt-config, ... }:
{
  imports = [
    ./scripts
    ./wayfire-config.nix
  ];
  home.file.".config/wayfire/waybar.jsonc".source = ./waybar.jsonc;
  home.file.".config/wayfire/waybar.css".source = ./waybar.css;
  
  home.packages = [
    pkgs.wayfire
  ];
}
