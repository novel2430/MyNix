{ lib, pkgs, opt-config, ...}:
{
  home.packages = [
    (import ./waybar.nix {
      inherit pkgs;
    })
    (import ./autostart.nix {
      inherit pkgs;
      inherit opt-config;
    })
  ];
}
