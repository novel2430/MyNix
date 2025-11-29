{pkgs, ...}:
let
  cliphist = "${pkgs.cliphist}/bin/cliphist";
  rofi = "${pkgs.rofi}/bin/rofi";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
in
pkgs.writeShellScriptBin "wlroot-clipboard" ''
  ${cliphist} list | ${rofi} -dmenu | ${cliphist} decode | ${wl-copy}
''
