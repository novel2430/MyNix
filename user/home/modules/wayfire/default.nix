{ config, pkgs, lib, opt-config, ... }:
{
  imports = [
    ./scripts
    ./wayfire-config.nix
    ./waybar.nix
  ];
  home.file.".config/wayfire/waybar.jsonc".source = ./waybar.jsonc;
  
  home.packages = [
    pkgs.wayfire
  ];
}
