{pkgs, ...}:
{
  home.file.".config/rofi/config.rasi".source = ./config.rasi;
  home.packages = [
    pkgs.rofi
  ];
}
