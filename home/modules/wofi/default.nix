{ config, pkgs, ... }:

{
  home.file.".config/wofi/config".source = ./config;
  home.file.".config/wofi/style.css".source = ./style.css;
  home.packages = [
    pkgs.wofi
  ];
}
