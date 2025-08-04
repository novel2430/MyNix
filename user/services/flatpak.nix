{lib, opt-config, ...}:
{
  services.flatpak = {

    packages = [
      "com.obsproject.Studio"
      "app.zen_browser.zen"
      "io.bassi.Amberol"
      "net.agalwood.Motrix"
      "be.alexandervanhee.gradia"
    ]++ opt-config.flatpak-packages;

    overrides = {
      global = {
        Context = {
          filesystems = [
            "xdg-config/fontconfig:ro" # Font
          ];
        };
      };
      "app.zen_browser.zen".Context = {
        filesystems = [
          "xdg-config/fontconfig:ro" # Font
        ];
      };
    };
  };
}
