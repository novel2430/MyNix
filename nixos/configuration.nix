# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, pkgs, allowed-unfree-packages, allowed-insecure-packages, opt-config, hostname, ... }:

{
  # Unfree Packages
  nixpkgs.config = {
    allowUnfreePredicate = allowed-unfree-packages;
    permittedInsecurePackages = allowed-insecure-packages;
  };

  imports = [ 
    ../hosts/${hostname}/hardware-configuration.nix
    ./modules/opengl.nix
    ./modules/xdg.nix
    ./modules/obs-virtual-camera.nix
    ./modules/sudo.nix
    ./modules/snd-usb-audio.nix
    ./modules/docker.nix
  ]
  ++
  lib.optionals (opt-config.gpu-type == "nvidia") [
    ./modules/nvidia.nix
  ]
  ++
  lib.optionals (opt-config.gpu-type == "intel-nvidia") [
    ./modules/nvidia.nix
  ]
  ++
  lib.optionals (opt-config.gpu-type == "amd") [
    ./modules/amd.nix
  ]
  ;

  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };
  # Kernel Modules
  boot.kernelModules = [
    "kvm"
  ];

  networking.hostName = "${hostname}"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager = {
      startx.enable = true;
    };
    # Configure keymap in X11
    xkb.layout = "us";
  };


  

  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${opt-config.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "libvirtd" "docker"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    tree
    htop
    gnumake
    cmake
    meson
    gcc
    gnutar
    htop
    ninja
    zip
    xz
    unzip
    p7zip
    ripgrep
    jq
    yq-go
    file
    which
    gnused
    gawk
    zstd
    strace
    ltrace
    lsof
    pciutils
    usbutils
    lshw
    dconf
    shared-mime-info
    glib
    swaylock-effects
    python312
    xdg-utils
    maven
    jdk17
    jdk21
    psmisc
    glfw
    libvirt
    dnsmasq
    bridge-utils
    flex
    bison
    iptables
    edk2
    usbmuxd
    libimobiledevice
  ];
  environment.variables.EDITOR = "vim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Dbus
  services.dbus.enable = true;
  # rtkit
  security.rtkit.enable = true;
  # usbmuxd
  services.usbmuxd.enable = true;
  # Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    extraConfig.pipewire = {
      "99-input-denoising" = {
        "context.modules" = [
          {   
            "name"= "libpipewire-module-filter-chain";
            "args" = {
              "node.description" =  "Noise Canceling source";
              "media.name" =  "Noise Canceling source";
              "filter.graph" = {
                "nodes" = [
                  {
                    "type" = "ladspa";
                    "name" = "rnnoise";
                    "plugin" = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                    "label" = "noise_suppressor_mono";
                    "control" = {
                      "VAD Threshold (%)" = 15.0;
                      "VAD Grace Period (ms)" = 200;
                      "Retroactive VAD Grace (ms)" = 0;
                    };
                  }
                ];
              };
              "capture.props" = {
                "node.name" =  "capture.rnnoise_source";
                "node.passive" = true;
                "audio.rate" = 48000;
              };
              "playback.props" = {
                "node.name" =  "rnnoise_source";
                "media.class" = "Audio/Source";
                "audio.rate" = 48000;
              };
            };
          }
        ];
      };
    };
  };
  # hardware.alsa.enablePersistence = true;
  # Swaylock PAM
  security.pam.services.swaylock = {};
  # Flatpak
  # services.flatpak.enable = true;

  # List programs that you want to enable:
  # dconf
  programs.dconf.enable = true;
  # Zsh
  programs.zsh.enable = true;
  # Auto cpu freq
  services.auto-cpufreq.enable = opt-config.autocpu;

  # Libvirtd
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # Mirror
  #nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  # Proxy
  systemd.services.nix-daemon.environment = lib.mkMerge [
    (lib.mkIf (opt-config.use-proxy == true) {
      https_proxy = "${opt-config.http-proxy}";
      http_proxy = "${opt-config.https-proxy}";
    }) 
  ];
  # Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

