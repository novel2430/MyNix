{ lib, pkgs, opt-config, ...}:
{
  home.packages = [
    (import ./waybar.nix {
      inherit pkgs;
    })
    (import ./autostart.nix {
      inherit lib;
      inherit pkgs;
      inherit opt-config;
    })
  ];
}
