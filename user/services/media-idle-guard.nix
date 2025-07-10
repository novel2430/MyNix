{pkgs, opt-config, ...}:
let
  id = "${pkgs.coreutils-full}/bin/id";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  xset = "${pkgs.xorg.xset}/bin/xset";
  xautolock = "${pkgs.xautolock}/bin/xautolock";
  pgrep = "${pkgs.procps}/bin/pgrep";
  awk = "${pkgs.gawk}/bin/awk";
  my-swayidle-path = import ../home/modules/scripts/my-swayidle.nix {
    inherit pkgs;
    inherit opt-config;
  };
  my-swayidle = "${my-swayidle-path}/bin/my-swayidle";
  xset-dpms-path = import ../home/modules/scripts/xset-dpms.nix {
    inherit pkgs;
    inherit opt-config;
  };
  xset-dpms = "${xset-dpms-path}/bin/xset-dpms";

  media-idle-guard-script = pkgs.writeShellScriptBin "media-idle-guard-script" ''

    if [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" ]]; then
      echo "No Desktop Session!"
      exit 0
    fi

    USERID=$(${id} -u ${opt-config.username})
    interval_time=10 #sec

    # fallback fallback fallback!
    export XAUTHORITY="/home/${opt-config.username}/.Xauthority"
    export XDG_RUNTIME_DIR="/run/user/$USERID"
    # for WAYLAND
    export WAYLAND_DISPLAY=$(cat "/home/${opt-config.username}/.wm_state" 2>/dev/null)

    is_playing=0

    while true; do
      swayidle_pid=$(${pgrep} -l "swayidle" | ${awk} '$2 == "swayidle" { print $1 }')
      locked_pid_betterlockscreen="$(${pgrep} -f betterlockscreen || true)"
      locked_pid_swaylock="$(${pgrep} -f swaylock || true)"
      if [[ -n "$locked_pid_betterlockscreen" || -n "$locked_pid_swaylock" ]]; then
        echo "[media_guard] Screen is LOCKED. Enabling idle lock."
        if (( is_playing == 1 )); then
          if [ "$WAYLAND_DISPLAY" == "X11" ]; then
            echo "[media_guard] (X11) xautolock disable detect, do enable"
            ${xset-dpms}
            # ${xautolock} -enable
          elif [[ -n "$swayidle_pid" && "$WAYLAND_DISPLAY" == wayland* ]]; then
            # wayland stuff
            echo "[media_guard] (Wayland) swayidle disable detect, do enable"
            ${my-swayidle} 2>/dev/null &
          fi
        fi
        is_playing=0
      else
        echo "[media_guard] Screen is UNLOCKED. Disabling idle lock."
        if (( is_playing == 0 )); then
          if [ "$WAYLAND_DISPLAY" == "X11" ]; then
            echo "[media_guard] (X11) xautolock enable detect, do disable"
            ${xset} -dpms
            # ${xautolock} -disable
          elif [[ -z "$swayidle_pid" && "$WAYLAND_DISPLAY" == wayland* ]]; then
            # wayland stuff
            echo "[media_guard] (Wayland) swayidle enable detect, do disable"
            kill -s TERM $swayidle_pid
          fi
        fi
        is_playing=1
      fi
      sleep $interval_time
    done

  '';
in
{
  systemd.user.services = {
    media-idle-guard = {
      enable = true;
      description = "Prevent lock/sleep during media playback (X11/Wayland)";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${media-idle-guard-script}/bin/media-idle-guard-script";
        Restart = "always";
      };
    };
  };
}
