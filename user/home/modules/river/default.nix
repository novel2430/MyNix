{ config, pkgs, lib, opt-config, ... }:
{
  imports = [
    ./generate-init.nix
    ./scripts
    ./waybar.nix
  ];

  home.file.".config/river/waybar.jsonc".source = ./waybar.jsonc;

  home.packages = [
    pkgs.river-classic
    pkgs.rivercarro
  ];
}
