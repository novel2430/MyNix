{pkgs, unstable-pkgs, astal, ags, ... }:
{
  dingtalk = pkgs.callPackage ./dingtalk {};
  novel-ags = pkgs.callPackage ./novel-ags {
    astal = astal;
    ags = ags;
  };
}
