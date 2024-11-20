{ lib, pkgs, opt-config, ...}:
{
  home.packages = [
    (import ./autostart.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./waybar.nix {
      inherit pkgs;
    })
  ];
}
