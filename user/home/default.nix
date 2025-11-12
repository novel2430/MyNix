{ config, lib, pkgs, modify-pkgs, custom-pkgs, inputs, opt-config, ... }:
let
  my-packages = with pkgs;[
    obs-studio
    motrix
    brave
    fastfetch
    socat
    wqy_zenhei
    papirus-icon-theme
    pwvucontrol
    nemo-with-extensions
    gsettings-desktop-schemas
    zathura
    image-roll
    spotify
    file-roller
    wl-clipboard
    python312
    brightnessctl
    wlr-randr
    ffmpeg
    vlc
    mpv
    xarchiver
    eza
    bat
    xclip
    playerctl
    ncspot
    lswt
    gradia # Like Small Painter
    swaybg

    # Modify Packages
    ## modify-pkgs.*
    # Custom Packages
    ## custom-pkgs.*
    # Unstable
    ## unstable.*
    ## unstable.*
    # NUR
    nur.repos.novel2430.FuzzyMarks
    nur.repos.novel2430.wemeet-bin-bwrap-wayland-screenshare
    nur.repos.novel2430.wechat-universal-bwrap
    # nur.repos.novel2430.wechat-appimage
    nur.repos.novel2430.zju-connect
    nur.repos.novel2430.wpsoffice-365
    nur.repos.novel2430.zen-browser-bin
    nur.repos.novel2430.gedit
    nur.repos.novel2430.dingtalk
    nur.repos.novel2430.baidunetdisk
    nur.repos.xddxdd.qq
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
