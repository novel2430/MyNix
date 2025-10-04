{ pkgs, opt-config, ... }:
let
  maim_cmd     = "${pkgs.maim}/bin/maim";
  dunstify_cmd = "${pkgs.dunst}/bin/dunstify";
  gradia       = "${pkgs.gradia}/bin/gradia";
  rofi_cmd     = "${pkgs.rofi-wayland}/bin/rofi";
in
pkgs.writeShellScriptBin "maim-screenshot" ''
  set -euo pipefail

  path="${opt-config.screenshot-dir}"
  mkdir -p "$path"

  now_date="$(date '+%Y%m%d-%H%M%S')"
  file_name="''${path}/''${now_date}.png"

  notify() {
    ${dunstify_cmd} -a "Screenshot" "$1" "saved as\n''${file_name}" -r 2003 || true
  }

  take_full() {
    ${maim_cmd} "''${file_name}"
  }

  take_select() {
    # maim -s: 取消会返回非 0；我们静默退出
    if ! ${maim_cmd} -s "''${file_name}"; then
      exit 0
    fi
  }

  do_edit() {
    ${gradia} "''${file_name}"
  }

  pick="''${1:-}"
  if [ -z "$pick" ]; then
    pick="$(${rofi_cmd} -dmenu -p "Screenshot (maim)" <<<'full
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
      exit 0
      ;;
  esac
''
