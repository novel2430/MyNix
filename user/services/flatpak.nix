{lib, opt-config, ...}:
{
  services.flatpak = {

    packages = [
      "com.tencent.wemeet"
      "com.dingtalk.DingTalk"
    ]++ opt-config.flatpak-packages;

    uninstallUnmanaged = false;
    update = {
      onActivation = false;
      auto = {
        enable = true;
        onCalendar = "weekly"; # Default value
      };
    };

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
