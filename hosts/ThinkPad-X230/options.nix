{pkgs, unstable-pkgs, ...}:
{
  opt-config = rec {
    # Basic
    username = "novel2430";

    # Git
    gitname = "novel2430";
    gitmail = "novel2430@163.com";
    gitbranch = "main";

    # Screenshots Directory
    screenshot-dir = "/home/${username}/Pictures/screenshot";
    # Wallpaper
    lock-img = "/home/${username}/.config/pics/lock";
    # Lock Paper
    wall-img = "/home/${username}/.config/pics/wall";

    # intel, nvidia, intel-nvidia
    gpu-type = "intel";
    intel-bus-id = "PCI:0:2:0";
    nvidia-bus-id = "PCI:3:0:0";

    # Monitors (For Wayfire Config)
    # Example :
    # "output:<monitor-name>" = {
    #   depth = "8";
    #   mode = "off";
    #   position = "auto";
    #   scale = "1.0";
    #   transform = "normal";
    #   vrr = "false";
    # }
    monitors = {
      "output:LVDS-1" = {
        depth = "8";
        mode = "1366x768";
        position = "auto";
        scale = "1.0";
        transform = "normal";
        vrr = "false";
      };
      "output:HDMI-A-1" = {
        depth = "8";
        mode = "mirror LVDS-1";
        position = "auto";
        scale = "1.0";
        transform = "normal";
        vrr = "false";
      };
    };
    # Monitors (For Hyprland Config)
    # Example :
    # hypr-monitors = [
    #   "eDP-1, disable"
    # ];
    hypr-monitors = [
    ];

    # Packages For this Machine
    packages = with pkgs; [
      hmcl
      audacity
      shotcut
    ];

    # Use Clash
    use-clash = true;
    clash-dir = "/home/${username}/clash";
    # Proxy
    use-proxy = true;
    http-proxy-host = "127.0.0.1";
    http-proxy-port = "7890";
    https-proxy-host = "127.0.0.1";
    https-proxy-port = "7890";
    http-proxy = "http://${http-proxy-host}:${http-proxy-port}";
    https-proxy = "http://${https-proxy-host}:${https-proxy-port}";

    # ZJU RVPN
    use-zju-rvpn = true;
    zju-rvpn-port = "1081";
    zju-rvpn-config = "/home/${username}/zjuconnect/config.toml";

    # Use AutoCPU
    autocpu = true;

    # No Keyboard
    no-keyboard = false;
  };
}
