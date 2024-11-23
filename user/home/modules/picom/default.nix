{ pkgs, ... }:
{
  home.file.".config/picom/picom.conf".source = ./picom.conf;
  home.packages = [
    pkgs.unstable.picom
  ];
}
