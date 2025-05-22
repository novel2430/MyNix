{pkgs, ...}:
let
  wl-present = "${pkgs.wl-mirror}/bin/wl-present";
in
pkgs.writeShellScriptBin "wl-mirror" ''
  ${wl-present} mirror
''
