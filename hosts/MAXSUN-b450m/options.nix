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
    lock-img = "/home/${username}/.config/wayfire/lock.png";
    # Lock Paper
    wall-img = "/home/${username}/.config/wayfire/wall.png";

    # intel, nvidia, intel-nvidia
    gpu-type = "amd";
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
    };
    # Monitors (For Hyprland Config)
    # Example :
    # hypr-monitors = [
    #   "eDP-1, disable"
    # ];
    hypr-monitors = [];

    # Packages For this Machine
    packages = with pkgs; [
      hmcl
      puddletag
      abcde
      cdrkit
      wavpack
      audacity
      shotcut
      docker
      qemu
      virt-manager
      ryujinx
      nsz
      openttd
      hugo
      # distrobox
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
    use-zju-rvpn = false;
    zju-rvpn-port = "7895";
    zju-rvpn-config = "/home/${username}/zjuconnect/config.toml";

    # In China
    in-china = true;

    # Use AutoCPU
    autocpu = false;

    # No Keyboard
    no-keyboard = false;
  };
}
