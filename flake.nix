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
    # Packages Setting
    pkg-settings = import ./settings/pkgs-settings.nix {
      inherit nixpkgs;
      inherit system;
      inherit nixpkgs-unstable;
      inherit nixpkgs-23;
      inherit nur;
    };
    # Host Config
    hosts-conf = import ./settings/hosts-conf.nix { inherit pkg-settings; };
    # Generate Function
    system-gen = {host-conf}: with pkg-settings; nixpkgs.lib.nixosSystem {
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
        # System Configuration
        ./system/configuration.nix
        # User's Services
        ./user/services/default.nix
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
  in
  {
    # Main Config Fuction
    nixosConfigurations = with hosts-conf;{
      # "${Default-conf.name}" = system-gen { host-conf = Default-conf; };
      "${ThinkPad-X230.name}" = system-gen { host-conf = ThinkPad-X230; };
      "${MAXSUN-b450m.name}" = system-gen { host-conf = MAXSUN-b450m; };
    };
  };
}
