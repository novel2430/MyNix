{pkgs, opt-config, ...}:
let
  hugo = "${pkgs.hugo}/bin/hugo";
  src = "/home/${opt-config.username}/hugo-my-web";
  dest = "/home/${opt-config.username}/novel2430.github.io";
in
pkgs.writeShellScriptBin "update-my-web" ''
  find ${dest} -mindepth 1 -not -path '${dest}/.git*' -delete
  ${hugo} -s ${src} -d ${dest}
''
