{pkgs, ...}:
let
  waybar = "${pkgs.waybar}/bin/waybar";
in
pkgs.writeShellScriptBin "my-hypr-run-waybar" ''
  ${waybar} -c ~/.config/hypr/waybar.jsonc -s ~/.config/hypr/waybar.css &
''
