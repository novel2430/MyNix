{ opt-config, pkgs, ... }:

{
  imports = [
    ./generate.nix
  ];
  home.packages = [
    pkgs.wofi
  ];
}
