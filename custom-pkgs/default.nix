{pkgs, unstable-pkgs, astal, ags, ... }:
{
  dingtalk = pkgs.callPackage ./dingtalk {};
  novel-ags = pkgs.callPackage ./novel-ags {
    astal = astal;
    ags = ags;
  };
  dwl = pkgs.callPackage ./dwl {};
  waybar = pkgs.callPackage ./waybar {};
  baidunetdisk = pkgs.callPackage ./baidunetdisk {
    # electron_11 = pkgs.nur.repos.xddxdd.electron_11;
    electron_11 = pkgs.callPackage ./baidunetdisk/electron_11.nix {};
  };
  electron_11 = pkgs.callPackage ./baidunetdisk/electron_11.nix {};
  wpsoffice-365 = pkgs.libsForQt5.callPackage ./wpsoffice-365 {};
  dwm = pkgs.callPackage ./dwm {};
  zen-browser-bin = pkgs.callPackage ./zen-browser {};
}
