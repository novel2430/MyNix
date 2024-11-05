{ lib, pkgs, opt-config, ...}:
{
  home.packages = [
    (import ./screenshot.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./show-clipboard.nix {
      inherit pkgs;
    })
    (import ./swayidle.nix {
      inherit pkgs;
    })
    (import ./swaylock.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./volume.nix {
      inherit pkgs;
    })
    (import ./waybar.nix {
      inherit pkgs;
    })
    (import ./autostart.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./power.nix {
      inherit pkgs;
      inherit opt-config;
    })
  ];
}
