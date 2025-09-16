{ pkgs, opt-config, custom-pkgs, ...}:
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
    (import ./maim-screenshot.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./wlroot-clipboard.nix {
      inherit pkgs;
    })
    (import ./my-swayidle.nix {
      inherit pkgs;
      inherit opt-config;
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
    (import ./greenclip-rofi.nix {
      inherit pkgs;
    })
    (import ./rofi-power-menu.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./xset-dpms.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./xautolock-idle.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./my-dwl-autostart.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./bemenu-start.nix {
      inherit pkgs;
    })
    (import ./bemenu-power-menu.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./bemenu-wlroot-clipboard.nix {
      inherit pkgs;
    })
    (import ./bemenu-drun.nix {
      inherit pkgs;
    })
    (import ./wl-mirror.nix {
      inherit pkgs;
    })
    (import ./waybar-modules-temp.nix {
      inherit pkgs;
    })
    (import ./waybar-modules-weather.nix {
      inherit pkgs;
    })
    (import ./dwl-waybar.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./dwm-polybar.nix {
      inherit pkgs;
      inherit opt-config;
      inherit custom-pkgs;
    })
    (import ./clash-switcher.nix {
      inherit pkgs;
      inherit opt-config;
    })
  ];
}
