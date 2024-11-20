{pkgs, opt-config, ...}:
let
  grim_cmd = "${pkgs.grim}/bin/grim";
  slurp_cmd = "${pkgs.slurp}/bin/slurp";
  dunstify_cmd = "${pkgs.dunst}/bin/dunstify";
in
pkgs.writeShellScriptBin "grim-slurp-screenshot" ''
  path="${opt-config.screenshot-dir}"
  now_date=''$(date '+%Y%m%d-%H%M%S')
  file_name="''${path}/''${now_date}.png"
  msg="save as ''${file_name}"

  mkdir -p $path

  case $1 in
    full)
      ${grim_cmd} ''${file_name} && ${dunstify_cmd} -a "Screenshot" "Full" "''${msg}" -r 2003
      ;;
    select)
      ${grim_cmd} -g "''$(${slurp_cmd})" ''${file_name} && ${dunstify_cmd} -a "Screenshot" "Select" "''${msg}" -r 2003
      ;;
  esac
''
