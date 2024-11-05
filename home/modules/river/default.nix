{ config, pkgs, lib, opt-config, ... }:
{
  imports = [
    ./init.nix
    ./scripts
  ];

  home.file.".config/river/waybar.jsonc".source = ./waybar.jsonc;
  home.file.".config/river/waybar.css".source = ./waybar.css;

  home.packages = [
    pkgs.river
    pkgs.rivercarro
  ];
}
