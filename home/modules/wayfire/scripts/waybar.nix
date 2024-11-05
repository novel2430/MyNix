{pkgs, ...}:
let
  waybar = "${pkgs.waybar}/bin/waybar";
in
pkgs.writeShellScriptBin "my-run-waybar" ''
  ${waybar} -c ~/.config/wayfire/waybar.jsonc -s ~/.config/wayfire/waybar.css &
''
