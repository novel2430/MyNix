{ pkgs, opt-config, ...}:
{
  home.packages = [
    (import ./volume.nix {
      inherit pkgs;
    })
    (import ./bluetooth.nix {
      inherit pkgs;
    })
    (import ./wofi-power-menu.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./grim-slurp-screenshot.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./scrot-screenshot.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./wlroot-clipboard.nix {
      inherit pkgs;
    })
    (import ./my-swayidle.nix {
      inherit pkgs;
    })
    (import ./my-swaylock.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./update-my-web.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./x-lock.nix {
      inherit pkgs;
    })
    (import ./start-wm.nix {
      inherit pkgs;
      inherit opt-config;
    })
  ];
}
