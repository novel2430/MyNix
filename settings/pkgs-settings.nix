{nixpkgs, system, nixpkgs-unstable, nixpkgs-23, nur }:
rec {
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
  stable-pkgs = import nixpkgs {
    inherit system;
    config.allowUnfreePredicate = allowed-unfree-packages;
    config.permittedInsecurePackages = allowed-insecure-packages;
  };
  # Unstable Brach Packages
  unstable-pkgs = import nixpkgs-unstable {
    inherit system;
    config.allowUnfreePredicate = allowed-unfree-packages;
    config.permittedInsecurePackages = allowed-insecure-packages;
    overlays = [ nur.overlay ];
  };
  # 23.11 Packages
  nix23-pkgs = import nixpkgs-23 {
    inherit system;
    config.allowUnfreePredicate = allowed-unfree-packages;
    config.permittedInsecurePackages = allowed-insecure-packages;
  };
  # Custom Packages
  custom-pkgs = import ../custom-pkgs {
    pkgs = stable-pkgs;
    unstable-pkgs = unstable-pkgs;
  };
  # Modify Packages
  modify-pkgs = import ../modify-pkgs {
    pkgs = stable-pkgs;
    unstable-pkgs = unstable-pkgs;
    nix23-pkgs = nix23-pkgs;
  };
}