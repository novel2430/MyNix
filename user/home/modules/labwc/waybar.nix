{pkgs, ...}:
let
  waybar = "${pkgs.waybar}/bin/waybar";
in
pkgs.writeShellScriptBin "labwc-waybar" ''
  ${waybar} -c ~/.config/labwc/waybar.jsonc -s ~/.config/labwc/waybar.css &
''
