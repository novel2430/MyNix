{pkgs, ...}:
let
  cliphist = "${pkgs.unstable.cliphist}/bin/cliphist";
  wofi = "${pkgs.wofi}/bin/wofi";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
in
pkgs.writeShellScriptBin "wlroot-clipboard" ''
  ${cliphist} list | ${wofi} show --dmenu | ${cliphist} decode | ${wl-copy}
''
