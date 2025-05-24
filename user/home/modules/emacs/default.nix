{pkgs, lib, doomemacs, ...}: 
let
doom = pkgs.writeShellScriptBin "doom" ''
  DOOMLOCALDIR=$HOME/.local/share/doomemacs DOOMDIR=$HOME/.doom.d.first ${doomemacs}/bin/doom "$@"
'';
emacs = pkgs.writeShellScriptBin "emacs" ''
  DOOMLOCALDIR=$HOME/.local/share/doomemacs DOOMDIR=$HOME/.doom.d.first ${pkgs.emacs}/bin/emacs "$@"
'';
in
{
  home.packages = [
    emacs
    pkgs.ripgrep
    pkgs.findutils
    pkgs.fd
    #pkgs.nerd-fonts.symbols-only
    pkgs.pandoc
    pkgs.shellcheck
    doom
  ];

  home.file.".emacs.d".source = doomemacs;

}
