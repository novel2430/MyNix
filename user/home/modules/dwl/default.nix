{pkgs, ...}:
{
  home.file.".config/dwl/waybar.jsonc".source = ./waybar.jsonc;
  home.file.".config/dwl/waybar.css".source = ./waybar.css;
}
