{ pkgs, opt-config, ... }:
let
  grim_cmd     = "${pkgs.grim}/bin/grim";
  slurp_cmd    = "${pkgs.slurp}/bin/slurp";
  dunstify_cmd = "${pkgs.dunst}/bin/dunstify";
  gradia       = "${pkgs.gradia}/bin/gradia";
  rofi_cmd     = "${pkgs.rofi}/bin/rofi";
in
pkgs.writeShellScriptBin "grim-slurp-screenshot" ''
  set -euo pipefail

  path="${opt-config.screenshot-dir}"
  mkdir -p "$path"

  now_date="$(date '+%Y%m%d-%H%M%S')"
  file_name="''${path}/''${now_date}.png"

  notify() {
    # $1 = title
    ${dunstify_cmd} -a "Screenshot" "$1" "saved as\n''${file_name}" -r 2003 || true
  }

  take_full() {
    ${grim_cmd} "''${file_name}"
  }

  take_select() {
    region="$(${slurp_cmd} || true)"
    [ -z "''${region:-}" ] && exit 0
    ${grim_cmd} -g "$region" "''${file_name}"
  }

  do_edit() {
    # 若需要阻塞直到编辑完成，保持前台；否则可在末尾加 &。
    ${gradia} "''${file_name}" &
  }

  pick="''${1:-}"
  if [ -z "$pick" ]; then
    pick="$(${rofi_cmd} -dmenu -p "Screenshot" <<<'full
select
full & edit
select & edit')"
  fi

  case "$pick" in
    "full")
      take_full && notify "Full"
      ;;
    "select")
      take_select && notify "Select"
      ;;
    "full & edit"|"full-edit")
      take_full && notify "Full + Edit" && do_edit
      ;;
    "select & edit"|"select-edit"|"edit")
      take_select && notify "Select + Edit" && do_edit
      ;;
    *)
      # 未选择或取消
      exit 0
      ;;
  esac
''

