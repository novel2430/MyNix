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
      "amd"
    ];
    intel-bus-id = "PCI:0:2:0";
    amd-bus-id = "PCI:10:0:0";
    nvidia-bus-id = "PCI:1:0:0";

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
      puddletag
      abcde
      cdrkit
      wavpack
      audacity
      docker
      qemu
      virt-manager
      ryujinx
      openttd
      hugo
      distrobox
      discord
      telegram-desktop
      lutris
      steam
      wine
      ppsspp
      reaper
      ardour
      nur.repos.novel2430.shotcut
      nur.repos.novel2430.vita3k
      wl-color-picker
      winetricks
      android-studio
      bilibili
      protonup-qt
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
    zju-rvpn-port = "7895";
    zju-rvpn-config = "/home/${username}/zjuconnect/config.toml";

    # Use AutoCPU
    autocpu = false;

    # Laptop Power Management
    laptop = false;

    # Bluetooth
    bluetooth = false;

    # No Keyboard
    no-keyboard = false;

    # Alacritty Fonst Size
    alacritty-font-size = "14";

    # AwesomeWM's Bar client title max len
    awesomewm-bar-client-title-max-len = "90";

    # Idle Wait Time
    idle = {
      dpms-standby = "1200"; # sec 1200
      dpms-off = "3600"; # sec 3600
      lock-sec = "3600"; # sec
      lock-min = "60"; # min
    };

    # Force Use opengl in GTK Application
    force-gl-gtk = false;
  };
}
