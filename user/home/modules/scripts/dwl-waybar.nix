{pkgs, opt-config, ...}:
let
  waybar = "${pkgs.waybar}/bin/waybar";
  killall = "${pkgs.psmisc}/bin/killall";
in
pkgs.writeShellScriptBin "my-dwl-waybar" ''
  ${killall} -r "waybar"
  exec ${waybar} -c /home/${opt-config.username}/.config/dwl/waybar.jsonc -s /home/${opt-config.username}/.config/dwl/waybar.css
''
