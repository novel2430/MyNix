{pkgs, unstable-pkgs, ... }:
{
  qutebrowser = pkgs.qt6Packages.callPackage ./qutebrowser { }; 
}
