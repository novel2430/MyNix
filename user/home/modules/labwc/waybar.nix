{pkgs, ...}:
let
  waybar = "${pkgs.nur.repos.novel2430.waybar-Consolatis-fork}/bin/waybar";
in
pkgs.writeShellScriptBin "labwc-waybar" ''
  ${waybar} -c ~/.config/labwc/waybar.jsonc -s ~/.config/labwc/waybar.css &
''
