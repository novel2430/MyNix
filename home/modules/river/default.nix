{ config, pkgs, lib, opt-config, ... }:
{
  imports = [
  ];

  home.file.".config/river/init" = {
    source = ./init.sh;
    executable = true;
  };
  
  home.packages = [
    pkgs.river
  ];
}
