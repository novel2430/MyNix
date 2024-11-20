{ config, pkgs, lib, opt-config, ... }:
{
  imports = [
    ./scripts
    ./wayfire-config.nix
  ];
  # home.file.".config/wayfire.ini".source = ./wayfire.ini;
  home.file.".config/wayfire/waybar.jsonc".source = ./waybar.jsonc;
  home.file.".config/wayfire/waybar.css".source = ./waybar.css;
  # home.file.".config/wayfire/wall.png".source = ./wall.png;
  # home.file.".config/wayfire/lock.png".source = ./lock.png;
  
  home.packages = [
    pkgs.wayfire
  ];
}
