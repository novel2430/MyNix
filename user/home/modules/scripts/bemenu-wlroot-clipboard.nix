{pkgs, ...}:
let
  cliphist = "${pkgs.unstable.cliphist}/bin/cliphist";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
in
pkgs.writeShellScriptBin "bemenu-wlroot-clipboard" ''
  ${cliphist} list | bemenu-start | ${cliphist} decode | ${wl-copy}
''
