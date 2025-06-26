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
    electron_11 = pkgs.nur.repos.xddxdd.electron_11;
  };
  wpsoffice-365 = pkgs.libsForQt5.callPackage ./wpsoffice-365 {};
}
