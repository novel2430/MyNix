{pkgs, custom-pkgs, unstable-pkgs, ...}:
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
      # X11
      dwm = false;
      awesome = false;
      i3 = false;
      openbox = true;
      # Wayland
      dwl = true;
      wayfire = true;
      river = false;
      labwc = true;
      niri = false;
      hypr = false;
      sway = false;
      mangowc = false;
    };

    # Packages For this Machine
    packages = with pkgs; [
      hugo
      wl-color-picker
      distrobox
      qemu
      virt-manager
      openttd
      chromium
      nur.repos.novel2430.shotcut-bin 
      nur.repos.novel2430.hmcl 
    ];
    flatpak-packages = [
      "com.discordapp.Discord"
      "fm.reaper.Reaper"
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
      dpms-standby = "300"; # sec 1200
      dpms-off = "300"; # sec 3600
      lock-sec = "300"; # sec
      lock-min = "60"; # min
    };
    
    # Force Use opengl in GTK Application
    force-gl-gtk = true;

    # BT
    use-qb = false;

    colors = {
      focus-border = "eceff4";
      unfocus-border = "3f3f36";
      bar-background = "2d2825";
      foreground = "eceff4";
      focus-background = "827f45";
      focus-sec-background = "646544";
      dmenu-background = "646544";
      dunst-background = "646544";
      dunst-border = "eceff4";
      terminal-background = "2d2e1a";
      terminal-foreground = "eceff4";
      gray = "999797";
      red = "bf616a";
      green = "b1d196";
      focus-background-rgb = "130,127,69"; # RGB of <focus-background>
    };
  };
}
