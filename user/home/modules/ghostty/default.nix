{ config, pkgs, ... }:

{
  home.file.".config/ghostty/config".source = ./config;
  home.packages = [
    pkgs.ghostty
  ];
}
