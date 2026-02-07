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
    gpu-type = [ "intel-nvidia" ];
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

    # WM Options
    wm = {
      # X11
      dwm = true;
      awesome = false;
      i3 = false;
      openbox = false;
      # Wayland
      dwl = true;
      wayfire = true;
      river = false;
      labwc = false;
      niri = false;
      hypr = false;
      sway = false;
      mangowc = false;
    };
    # Packages For this Machine
    packages = with pkgs; [
      hmcl
      openttd
      docker
      qemu
      virt-manager
      lutris
      # steam
      wine
      winetricks
      protonup-qt
      #blender
    ];
    flatpak-packages = [
      # "org.ppsspp.PPSSPP"
      #"com.discordapp.Discord"
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
    use-zju-rvpn = false;
    zju-rvpn-port = "7895";
    zju-rvpn-config = "/home/${username}/zjuconnect/config.toml";

    # Use AutoCPU
    autocpu = false;

    # Laptop Power Management
    laptop = false;

    # Bluetooth
    bluetooth = false;

    # No Keyboard
    no-keyboard = true;

    # Alacritty Fonst Size
    alacritty-font-size = "13";

    # AwesomeWM's Bar client title max len
    awesomewm-bar-client-title-max-len = "36";

    # Idle Wait Time
    idle = {
      dpms-standby = "300"; # sec 1200
      dpms-off = "300"; # sec 3600
      lock-sec = "300"; # sec
      lock-min = "60"; # min
    };
    
    # Force Use opengl in GTK Application
    force-gl-gtk = false;

    # BT
    use-qb = false;

    colors = {
      focus-border = "eceff4";
      unfocus-border = "3f3f36";
      bar-background = "2d2825";
      foreground = "eceff4";
      focus-background = "5e936c";
      focus-sec-background = "827f45";
      dmenu-background = "3e5f44";
      dunst-background = "3e5f44";
      dunst-border = "eceff4";
      terminal-background = "2d2825";
      terminal-foreground = "eceff4";
      gray = "999797";
      red = "bf616a";
      green = "b1d196";
      focus-background-rgb = "94,147,108"; # RGB of <focus-background>
    };
  };
}
