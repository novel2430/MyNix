{lib, opt-config, ...}:
{
  services.flatpak = {

    packages = [
      "com.obsproject.Studio"
      "app.zen_browser.zen"
      "io.bassi.Amberol"
      "net.agalwood.Motrix"
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
