{pkgs, opt-config, custom-pkgs, ...}:
let
  killall = "${pkgs.psmisc}/bin/killall";
  polybar = "${custom-pkgs.polybar-dwm}/bin/polybar";
in
pkgs.writeShellScriptBin "dwm-polybar" ''
  exec ${polybar} -c "/home/${opt-config.username}/.dwm/config.ini"
''
