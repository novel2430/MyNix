{pkgs, ...}:
let
  betterlockscreen = "${pkgs.betterlockscreen}/bin/betterlockscreen";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
in
pkgs.writeShellScriptBin "x-lock" ''
  ${playerctl} play-pause 
  ${betterlockscreen} -l
''
