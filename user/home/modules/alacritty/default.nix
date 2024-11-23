{ pkgs, ... }:
{
  home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  # home.packages = [
  #   pkgs.alacritty
  # ];
}
