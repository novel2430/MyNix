{ pkgs, opt-config, ...}:
{
  home.packages = [
    (import ./volume.nix {
      inherit pkgs;
    })
    (import ./power.nix {
      inherit pkgs;
      inherit opt-config;
    })
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
  ];
}
