{nixpkgs, system, nixpkgs-unstable, nur, nixpkgs-2405, astal, ags }:
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
    "discord"
    "steam"
    "steam-original"
    "steam-unwrapped"
    "wpsoffice-365"
    "reaper"
    # CUDA
    "cuda-merged"
    "cuda_cuobjdump"
    "cuda_gdb"
    "cuda_nvcc"
    "cuda_nvdisasm"
    "cuda_nvprune"
    "cuda_cccl"
    "cuda_cudart"
    "cuda_cupti"
    "cuda_cuxxfilt"
    "cuda_nvml_dev"
    "cuda_nvrtc"
    "cuda_nvtx"
    "cuda_profiler_api"
    "cuda_sanitizer_api"
    "libcublas"
    "libcufft"
    "libcurand"
    "libcusolver"
    "libnvjitlink"
    "libcusparse"
    "libnpp"
    "android-studio-stable"
    "bilibili"
    "wechat-appimage"
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
    overlays = [ nur.overlay ];
  };
  # Unstable Brach Packages
  unstable-pkgs = import nixpkgs-unstable {
    inherit system;
    config.allowUnfreePredicate = allowed-unfree-packages;
    config.permittedInsecurePackages = allowed-insecure-packages;
    overlays = [ nur.overlay ];
  };
  # Custom Packages
  custom-pkgs = import ../custom-pkgs {
    pkgs = stable-pkgs;
    unstable-pkgs = unstable-pkgs;
    astal = astal.packages.${system};
    ags = ags.packages.${system}.default;
  };
  # Modify Packages
  modify-pkgs = import ../modify-pkgs {
    pkgs = stable-pkgs;
    unstable-pkgs = unstable-pkgs;
  };
  # Nixpkgs 24.05
  pkgs-2405 = import nixpkgs-2405 {
    inherit system;
    config.allowUnfreePredicate = allowed-unfree-packages;
    config.permittedInsecurePackages = allowed-insecure-packages;
    overlays = [ nur.overlay ];
  };
}
