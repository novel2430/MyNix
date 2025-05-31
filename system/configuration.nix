# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, pkgs, allowed-unfree-packages, allowed-insecure-packages, opt-config, hostname, options, ... }:

{
  # Unfree Packages
  nixpkgs.config = {
    allowUnfreePredicate = allowed-unfree-packages;
    permittedInsecurePackages = allowed-insecure-packages;
  };

  imports = [ 
    ../hosts/${hostname}/hardware-configuration.nix
    ./user.nix
    ./packages.nix
    ./modules/opengl.nix
    ./modules/xdg.nix
    ./modules/obs-virtual-camera.nix
    ./modules/sudo.nix
    ./modules/snd-usb-audio.nix
    ./modules/docker.nix
    ./modules/virt-machine.nix
    ./modules/garbage-collect.nix
    ./services/xserver.nix
    ./services/pipewire.nix
    ./services/others.nix
    ./services/upower.nix
  ]
  ++
  lib.optionals (opt-config.laptop == true) [
    ./modules/laptop-power-management.nix
  ]
  ++
  lib.optionals (opt-config.bluetooth == true) [
    ./modules/bluetooth.nix
  ]
  ++
  lib.optionals (builtins.elem "nvidia" opt-config.gpu-type) [
    ./modules/nvidia.nix
  ]
  ++
  lib.optionals (builtins.elem "intel-nvidia" opt-config.gpu-type) [
    ./modules/nvidia.nix
  ]
  ++
  lib.optionals (builtins.elem "amd-nvidia" opt-config.gpu-type) [
    ./modules/nvidia.nix
    ./modules/amd.nix
  ]
  ++
  lib.optionals (builtins.elem "amd" opt-config.gpu-type) [
    ./modules/amd.nix
  ]
  ;
  
  # services.xserver.enable = true;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # services.desktopManager.plasma6.enable = true;

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

  # NTP
  networking.timeServers = options.networking.timeServers.default ++ [ "tw.ntp.org.cn" ];
  services.ntp.enable = true;

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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  services.pulseaudio.enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.variables.EDITOR = "vim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Swaylock PAM
  security.pam.services.swaylock = {};

  # List programs that you want to enable:
  # dconf
  programs.dconf.enable = true;
  # Zsh
  programs.zsh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [
  #   {
  #     from = 1714;
  #     to = 1764;
  #   }
  # ];
  # networking.firewall.allowedUDPPorts = [
  #   {
  #     from = 1714;
  #     to = 1764;
  #   }
  # ];
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

