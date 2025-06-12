{pkgs, opt-config, ...}:
{
  home.file.".config/wezterm/wezterm.lua" = {
    source = ./wezterm.lua;
  };
  home.file.".config/wezterm/config" = {
    recursive = true;
    source = ./config;
  };

  home.packages = [
    pkgs.wezterm
  ];
}
