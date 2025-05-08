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

  # home.file.".config/awesome/config/var.lua".source = ./lua/config/var.lua;
  # home.file.".config/awesome/config/my_widgets.lua".source = ./lua/config/my_widgets.lua;
  # home.file.".config/awesome/config/error_handling.lua".source = ./lua/config/error_handling.lua;
  # home.file.".config/awesome/config/my_wibox.lua".source = ./lua/config/my_wibox.lua;
  # home.file.".config/awesome/config/my_keys.lua".source = ./lua/config/my_keys.lua;
  # home.file.".config/awesome/config/my_rules.lua".source = ./lua/config/my_rules.lua;
  # home.file.".config/awesome/config/my_signals.lua".source = ./lua/config/my_signals.lua;
}
