{pkgs, ...}:
{

  home.file.".config/polybar/config.ini".source = ./config.ini;

  home.packages = [
    pkgs.polybar
  ];
}
