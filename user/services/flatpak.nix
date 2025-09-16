{lib, opt-config, ...}:
{
  services.flatpak = {

    packages = [

    ]++ opt-config.flatpak-packages;

    overrides = {
      global = {
        Context = {
          filesystems = [
            "xdg-config/fontconfig:ro" # Font
            "/run/current-system/sw/share/X11/fonts:ro" #Font
            "/nix/store:ro"
          ];
        };
      };
    };
  };
}
