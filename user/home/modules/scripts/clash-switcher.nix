{pkgs, opt-config, ...}:
let
  dunstify = "${pkgs.dunst}/bin/dunstify";
  find = "${pkgs.findutils}/bin/find";
  rofi = "${pkgs.rofi}/bin/rofi";
in
pkgs.writeShellScriptBin "clash-switcher" ''
  choice="$(
    ${find} "${opt-config.clash-dir}" -type f -name '*.yaml' \
    | ${rofi} -dmenu
  )"
  [ -n "$choice" ] && cp "$choice" "${opt-config.clash-dir}/config.yaml" \
  && systemctl --user restart mihomo.service \
  && ${dunstify} -a "Update Clash" "Now using $choice" -r 2004
''
