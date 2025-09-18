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
      "amd-nvidia"
    ];
    intel-bus-id = "PCI:0:2:0";
    amd-bus-id = "PCI:10:0:0";
    nvidia-bus-id = "PCI:1:0:0";
    nvidia-legacy = true;

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
      # Wayland
      dwl = true;
      wayfire = true;
      river = false;
      labwc = false;
    };

    # Packages For this Machine
    packages = with pkgs; [
      hmcl
      abcde
      cdrkit
      wavpack
      docker
      qemu
      virt-manager
      hugo
      distrobox
      lutris
      steam
      wine
      nur.repos.novel2430.vita3k
      nur.repos.novel2430.shotcut-bin 
      wl-color-picker
      winetricks
      android-studio
      bilibili
      protonup-qt
      openttd
      ryubing #ryujinx
    ];
    flatpak-packages = [
      "org.audacityteam.Audacity"
      "com.discordapp.Discord"
      "org.telegram.desktop"
      "org.ppsspp.PPSSPP"
      "fm.reaper.Reaper"
      "org.ardour.Ardour"
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
      dpms-standby = "300"; # sec 1200
      dpms-off = "300"; # sec 3600
      lock-sec = "300"; # sec
      lock-min = "60"; # min
    };

    # Force Use opengl in GTK Application
    force-gl-gtk = false;
  };
}
