{pkgs, ...}:
let
  j4-dmenu-desktop = "${pkgs.j4-dmenu-desktop}/bin/j4-dmenu-desktop";
in
pkgs.writeShellScriptBin "bemenu-drun" ''
  ${j4-dmenu-desktop} -d "bemenu-start"
''
