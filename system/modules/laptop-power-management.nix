{pkgs, opt-config,  ...}:
let
  wayland-lock = import ../../user/home/modules/scripts/my-swaylock.nix {
    inherit pkgs;
    inherit opt-config;
  };
  bright = "${pkgs.brightnessctl}/bin/brightnessctl";
  handle-lid = pkgs.writeShellScriptBin "handle-lid" ''
    bat_state=$(${pkgs.acpi}/bin/acpi -b | grep -oP '(?<=: ).*?(?=,)' )
    user_id=$(${pkgs.coreutils-full}/bin/id -u ${opt-config.username})
    VARIABLE="WAYLAND_DISPLAY"
    PIDS=$(${pkgs.procps}/bin/ps -u ${opt-config.username} | ${pkgs.gawk}/bin/awk '/Xwayland/ {print $1}')

    if [ "$bat_state" == "Discharging" ]; then
      echo "[LID] BAT Discharging"
      # Find WAYLAND_DISPLAY (Use Xwayland to identified)
      if [ -z "$PIDS" ]; then
        systemctl suspend
        exit 0
      fi

      for PID in $PIDS; do
        if [ -e /proc/$PID/environ ]; then
          ENVIRONMENT=$( ${pkgs.coreutils-full}/bin/tr '\0' '\n' < /proc/$PID/environ | grep "^$VARIABLE=" | ${pkgs.coreutils-full}/bin/cut -d= -f2)
          if [ -n "$ENVIRONMENT" ]; then
            export WAYLAND_DISPLAY="$ENVIRONMENT" 
            echo "Current Wayland : $WAYLAND_DISPLAY"
            export XDG_RUNTIME_DIR=/run/user/$user_id
            ${wayland-lock}/bin/my-swaylock idle &
            ${pkgs.coreutils-full}/bin/sleep 2
            systemctl suspend
            exit 0
          fi
        fi
      done
      systemctl suspend
    elif [ "$bat_state" == "Charging" ]; then
      echo "[LID] BAT Charging"
    fi
  '';
in
{
  # Do not use systemd.logind
  services.logind = {
    hibernateKey = "ignore";
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };
  # Allow Suspend to RAM
  powerManagement.enable = true;
  # acpid
  services.acpid = {
    enable = true;
    handlers = {
      ac-power = {
        action = ''
          vals=($1)  # space separated string to array of multiple values
          case ''${vals[3]} in
            00000000)
              echo unplugged
              echo unplugged >> /tmp/acpi.log
              ${bright} set 30%
              ;;
            00000001)
              echo plugged in
              echo plugged in >> /tmp/acpi.log
              ${bright} set 80%
              ;;
            *)
              ;;
          esac
        '';
        event = "ac_adapter/*";
      };
      lid-action = {
        action = ''
          vals=($1)  # space separated string to array of multiple values
          case ''${vals[2]} in
            close)
              echo LID closed
              echo LID closed >> /tmp/acpi.log
              ${handle-lid}/bin/handle-lid
              ;;
            open)	
              echo LID opened
              echo LID opened >> /tmp/acpi.log
              ;;
            *) 
              ;;
          esac
        '';
        event = "button/lid.*";
      };
    };
  };

}
