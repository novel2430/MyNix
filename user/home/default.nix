{ config, lib, pkgs, modify-pkgs, custom-pkgs, pkgs-2405, inputs, opt-config, ... }:
let
  my-packages = with pkgs;[
    fastfetch
    socat
    upower
    obs-studio
    glxinfo
    wqy_zenhei
    noto-fonts-color-emoji
    papirus-icon-theme
    pavucontrol
    celluloid
    # gedit
    nemo-with-extensions
    gsettings-desktop-schemas
    gtk3
    amberol
    zathura
    image-roll
    spotify
    motrix
    file-roller
    wl-clipboard
    python3
    rustc
    cargo
    appimage-run
    brightnessctl
    wlr-randr
    ffmpeg
    vlc
    ifuse
    mpv
    xarchiver
    krusader
    konsole
    eza
    bat
    inputs.astal.packages.${system}.default
    # Modify Packages
    ## modify-pkgs.*
    # Custom Packages
    ## custom-pkgs.*
    custom-pkgs.dingtalk
    custom-pkgs.novel-ags
    # Unstable
    ## unstable.*
    # NUR
    nur.repos.novel2430.FuzzyMarks
    nur.repos.novel2430.wemeet-bin-bwrap-wayland-screenshare
    # nur.repos.novel2430.wemeet-bin-bwrap
    nur.repos.novel2430.wechat-universal-bwrap
    nur.repos.novel2430.zju-connect
    # nur.repos.novel2430.wpsoffice
    nur.repos.novel2430.wpsoffice-365
    nur.repos.novel2430.gedit
    nur.repos.xddxdd.baidunetdisk
    # nur.repos.xddxdd.dingtalk
    nur.repos.xddxdd.qq
    # pkgs-2405.nur.repos.xddxdd.dingtalk
  ]
  ++ opt-config.packages
  ;
in
{
  home.username = "${opt-config.username}";
  home.homeDirectory = "/home/${opt-config.username}";

  imports = [
    ./modules
  ];

  home.packages = my-packages;

  # XDG_DATA_DIRS
  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    # flatpak
    # "/var/lib/flatpak/exports/share"
    # "$HOME/.local/share/flatpak/exports/share"
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
