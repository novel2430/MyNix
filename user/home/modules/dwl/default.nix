{custom-pkgs, ...}:
{
  imports = [
    ./waybar.nix
  ];
  home.file.".config/dwl/waybar.jsonc".source = ./waybar.jsonc;
  home.packages = [
    custom-pkgs.dwl
  ];
}
