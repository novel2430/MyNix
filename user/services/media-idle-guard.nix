{pkgs, opt-config, ...}:
let
  id = "${pkgs.coreutils-full}/bin/id";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  xset = "${pkgs.xorg.xset}/bin/xset";
  xautolock = "${pkgs.xautolock}/bin/xautolock";
  media-idle-guard-script = pkgs.writeShellScriptBin "media-idle-guard-script" ''

    if [[ -z "$DISPLAY" ]]; then
      echo "No Desktop Session!"
      exit 0
    fi

    USERID=$(${id} -u ${opt-config.username})
    interval_time=10 #sec

    # fallback fallback fallback!
    export XAUTHORITY="/home/${opt-config.username}/.Xauthority"
    export XDG_RUNTIME_DIR="/run/user/$USERID"

    flag="1"
    while true; do
      if ${playerctl} status 2>/dev/null | grep -q Playing; then
        echo "[media_guard] Playing..."
        echo "[media_guard] disable xautolock + disable dpms"
        ${xset} -dpms
        ${xautolock} -disable
        flag="0"
      else
        echo "[media_guard] Not playing."
        echo "[media_guard] re-enable xautolock + re-enable dpms"
        ${xset} +dpms
        if [ "$flag" == "0" ]; then
          flag="1"
          echo "[media_guard] xautolock disable detect, do enable"
          ${xautolock} -enable
        fi
      fi
      sleep $interval_time
    done

  '';
in
{
  systemd.user.services = {
    media-idle-guard = {
      enable = true;
      description = "Prevent lock/sleep during media playback (X11)";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${media-idle-guard-script}/bin/media-idle-guard-script";
        Restart = "always";
      };
    };
  };
}
