{ pkgs, opt-config, ... }:
{
  imports = [
    ./scripts
  ];
  home.packages = [
    pkgs.awesome
  ];

  # Lua Files
  home.file.".config/awesome/rc.lua".source = ./lua/rc.lua;
  home.file.".config/awesome/config" = {
    recursive = true;
    source = ./lua/config;
  };
}
