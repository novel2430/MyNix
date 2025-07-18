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

    # intel, nvidia, intel-nvidia, amd
    gpu-type = [
      "intel"
    ];
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
      # "output:LVDS-1" = {
      #   depth = "8";
      #   mode = "1366x768";
      #   position = "auto";
      #   scale = "1.0";
      #   transform = "normal";
      #   vrr = "false";
      # };
      # "output:HDMI-A-1" = {
      #   depth = "8";
      #   mode = "mirror LVDS-1";
      #   position = "auto";
      #   scale = "1.0";
      #   transform = "normal";
      #   vrr = "false";
      # };
    };
    # Monitors (For Hyprland Config)
    # Example :
    # hypr-monitors = [
    #   "eDP-1, disable"
    # ];

    # WM Options
    wm = {
      wayfire = true;
      river = true;
    };

    # Packages For this Machine
    packages = with pkgs; [
      hmcl
      audacity
      hugo
      wl-color-picker
      distrobox
      reaper
      discord
      qemu
      virt-manager
      nur.repos.novel2430.shotcut
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

    # Laptop Power Management
    laptop = true;

    # Bluetooth
    bluetooth = false;

    # No Keyboard
    no-keyboard = false;

    # Alacritty Fonst Size
    alacritty-font-size = "13";

    # AwesomeWM's Bar client title max len
    awesomewm-bar-client-title-max-len = "36";

    # Idle Wait Time
    idle = {
      dpms-standby = "1200"; # sec
      dpms-off = "3600"; # sec
      lock-sec = "3600"; # sec
      lock-min = "60"; # min
    };
    
    # Force Use opengl in GTK Application
    force-gl-gtk = true;
  };
}
