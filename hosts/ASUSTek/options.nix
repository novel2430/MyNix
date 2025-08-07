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
    gpu-type = [ "intel" ];
    intel-bus-id = "";
    nvidia-bus-id = "";

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

    # WM Options
    wm = {
      wayfire = true;
      river = true;
    };
    # Packages For this Machine
    packages = with pkgs; [
      hmcl
      hugo
    ];
    flatpak-packages = [
      "org.openttd.OpenTTD"
      "org.ppsspp.PPSSPP"
    ];

    # Use Clash
    use-clash = false;
    clash-dir = "/home/${username}/clash";
    # Proxy
    use-proxy = false;
    http-proxy-host = "127.0.0.1";
    http-proxy-port = "7890";
    https-proxy-host = "127.0.0.1";
    https-proxy-port = "7890";
    http-proxy = "http://${http-proxy-host}:${http-proxy-port}";
    https-proxy = "http://${https-proxy-host}:${https-proxy-port}";

    # ZJU RVPN
    use-zju-rvpn = true;
    zju-rvpn-port = "7895";
    zju-rvpn-config = "/home/${username}/zjuconnect/config.toml";

    # Use AutoCPU
    autocpu = false;

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
      dpms-standby = "600"; # sec
      dpms-off = "600"; # sec
      lock-sec = "600"; # sec
      lock-min = "10"; # min
    };
    
    # Force Use opengl in GTK Application
    force-gl-gtk = false;
  };
}
