{pkgs, ...}:
let
  waybar = "${pkgs.waybar}/bin/waybar";
in
pkgs.writeShellScriptBin "river-waybar" ''
  ${waybar} -c ~/.config/river/waybar.jsonc -s ~/.config/river/waybar.css &
''
