{pkgs, ...}:
let
  betterlockscreen = "${pkgs.betterlockscreen}/bin/betterlockscreen";
in
pkgs.writeShellScriptBin "x-lock" ''
  ${betterlockscreen} -l
''
