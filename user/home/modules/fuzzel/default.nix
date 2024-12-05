{ opt-config, pkgs, ... }:

{
  home.file.".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;
  home.packages = [
    pkgs.fuzzel
  ];
}
