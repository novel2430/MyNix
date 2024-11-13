{
  description = "My NixOS flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-23.url = "github:NixOS/nixpkgs/nixos-23.11";
    # Unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # HomeManager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NUR
    nur = {
      url = "github:nix-community/NUR";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-23, home-manager, nur, ... }@inputs:
  let
    system = "x86_64-linux";
    # Host Config
    # List:
    #   Default
    #   LENOVO-Torronto-5C2
    #   Timi-TM1701
    Default-conf = rec {
      name = "Default";
      config = (import ./hosts/${name}/options.nix { pkgs = stable-pkgs; unstable-pkgs = unstable-pkgs; }).opt-config;
    };
    LENOVO-5C2-conf = rec {
      name = "LENOVO-Torronto-5C2";
      config = (import ./hosts/${name}/options.nix).opt-config;
    };
    Timi-TM1701-conf = rec {
      name = "Timi-TM1701";
      config = (import ./hosts/${name}/options.nix).opt-config;
    };
    ThinkPad-X230-conf = rec {
      name = "ThinkPad-X230";
      config = (import ./hosts/${name}/options.nix { pkgs = stable-pkgs; unstable-pkgs = unstable-pkgs; }).opt-config;
    };
    ASUSTek-conf = rec {
      name = "ASUSTek";
      config = (import ./hosts/${name}/options.nix).opt-config;
    };
    MAXSUN-b450m-conf = rec {
      name = "MAXSUN-b450m";
      config = (import ./hosts/${name}/options.nix { pkgs = stable-pkgs; unstable-pkgs = unstable-pkgs; }).opt-config;
    };

    # Superset of the default unfree packages
    allowed-unfree-packages = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "spotify"
      "wpsoffice"
      "baidunetdisk"
      "dingtalk"
      "qq"
      "wechat-universal-bwrap"
      "wemeet-bin-bwrap"
      "amdgpu-pro"
      "wechat-uos"
      "widevine-cdm"
    ];
    # Superset of the default insecure packages
    allowed-insecure-packages = [
      "electron-11.5.0"
      "openssl-1.1.1w"
    ];
    # Stable Brach Packages
    stable-pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfreePredicate = allowed-unfree-packages;
      config.permittedInsecurePackages = allowed-insecure-packages;
    };
    # Unstable Brach Packages
    unstable-pkgs = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfreePredicate = allowed-unfree-packages;
      config.permittedInsecurePackages = allowed-insecure-packages;
      overlays = [ nur.overlay ];
    };
    # 23.11 Packages
    nix23-pkgs = import inputs.nixpkgs-23 {
      inherit system;
      config.allowUnfreePredicate = allowed-unfree-packages;
      config.permittedInsecurePackages = allowed-insecure-packages;
    };
    # Custom Packages
    custom-pkgs = import ./custom-pkgs {
      pkgs = stable-pkgs;
      unstable-pkgs = unstable-pkgs;
    };
    # Modify Packages
    modify-pkgs = import ./modify-pkgs {
      pkgs = stable-pkgs;
      unstable-pkgs = unstable-pkgs;
      nix23-pkgs = nix23-pkgs;
    };

  in
  rec {
    # Generate Function
    system-gen = {host-conf}: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit allowed-unfree-packages;
        inherit allowed-insecure-packages;
        opt-config = host-conf.config;
        hostname = host-conf.name;
      };
      modules = [
        # Add NUR
        { nixpkgs.overlays = [ nur.overlay ]; }
        # Add Unstable Nixpkg
        ({
          nixpkgs.overlays = [
            (final: prev: {
              unstable = unstable-pkgs;
            })
          ];
        })
        # Add NixOS-23 Nixpkg
        ({
          nixpkgs.overlays = [
            (final: prev: {
              nix23 = nix23-pkgs;
            })
          ];
        })
        # Basic Configuration
        ./nixos/configuration.nix
        # Service
        ./services/default.nix
        # Home Manager
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${host-conf.config.username} = import ./home;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            opt-config = host-conf.config;
            inherit modify-pkgs;
            inherit custom-pkgs;
          };
        }
      ];
    };
    # Main Config Fuction
    nixosConfigurations = {
      "${Default-conf.name}" = system-gen { host-conf = Default-conf; };
      "${LENOVO-5C2-conf.name}" = system-gen { host-conf = LENOVO-5C2-conf; };
      "${Timi-TM1701-conf.name}" = system-gen { host-conf = Timi-TM1701-conf; };
      "${ThinkPad-X230-conf.name}" = system-gen { host-conf = ThinkPad-X230-conf; };
      "${ASUSTek-conf.name}" = system-gen { host-conf = ASUSTek-conf; };
      "${MAXSUN-b450m-conf.name}" = system-gen { host-conf = MAXSUN-b450m-conf; };
    };
  };
}
