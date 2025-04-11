{ lib, pkgs, opt-config, modify-pkgs, ...}:
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
