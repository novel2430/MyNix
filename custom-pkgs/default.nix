{pkgs, pkgs-2505, ... }:
{
  dingtalk = pkgs.callPackage ./dingtalk {};
  # novel-ags = pkgs.callPackage ./novel-ags {
  #   astal = astal;
  #   ags = ags;
  # };
  dwl = pkgs.callPackage ./dwl {};
  waybar = pkgs.callPackage ./waybar {};
  dwm = pkgs.callPackage ./dwm {};
  polybar-dwm = pkgs.callPackage ./polybar-dwm {};
  # shotcut-bin = pkgs.callPackage ./shotcut {};
  hmcl = pkgs.callPackage ./hmcl {};
  gedit = pkgs-2505.callPackage ./gedit {};
}
