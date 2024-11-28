{pkgs, unstable-pkgs, ... }:
{
  qutebrowser = pkgs.qt6Packages.callPackage ./qutebrowser { }; 
  zzz = pkgs.callPackage ./zzz { }; 
}
