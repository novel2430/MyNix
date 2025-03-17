{ pkgs, ... }:
{
  home.file.".config/fastfetch/config.jsonc".source = ./config.json;
  home.packages = [
    pkgs.fastfetch
  ];
}
