{ pkgs, unstable-pkgs, nix23-pkgs, ... }:
{
  brave = (import ./brave.nix { 
    pkgs = pkgs; 
    unstable-pkgs = unstable-pkgs;
    nix23-pkgs = nix23-pkgs;
  }).brave;
}
