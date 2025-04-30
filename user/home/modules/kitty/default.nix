{ config, pkgs, ... }:

{
  home.file.".config/kitty/kitty.conf".source = ./kitty.conf;
  home.packages = [
    pkgs.kitty
  ];
}
