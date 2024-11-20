{ config, pkgs, ... }:

{
  home.file.".config/dunst/dunstrc".source = ./dunstrc;
  home.packages = [
    pkgs.dunst 
  ];
}
