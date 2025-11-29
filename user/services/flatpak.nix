{lib, opt-config, ...}:
{
  services.flatpak = {

    packages = [
      "com.tencent.wemeet"
    ]++ opt-config.flatpak-packages;

    uninstallUnmanaged = false;

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
