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
    WAYLAND_DISPLAY=$(cat /home/${opt-config.username}/.wm_state)
    if [ "$bat_state" == "Discharging" ]; then
      echo "[LID] BAT Discharging"
      if [ -z "$WAYLAND_DISPLAY" ]; then
        systemctl suspend
      elif [ "$WAYLAND_DISPLAY" == "X11" ]; then
        systemctl suspend
      else
        export XDG_RUNTIME_DIR=/run/user/$user_id
        ${wayland-lock}/bin/my-swaylock idle &
        ${pkgs.coreutils-full}/bin/sleep 2
        systemctl suspend
      fi
    elif [ "$bat_state" == "Charging" ]; then
      echo "[LID] BAT Charging"
    fi
  '';
  handle-bright = pkgs.writeShellScriptBin "handle-bright" ''
    current_val=$(${bright} get)
    max_val=$(${bright} max)
    current_per=$(${pkgs.gawk}/bin/awk '{print $1*$2/$3}' <<<"$current_val 100 $max_val")
    echo "Current Bright : $current_per%"
    if [ $1 == "low" ] && echo "$current_per > 30" | ${pkgs.bc}/bin/bc -l | grep -q 1; then
      ${bright} set 30%
    elif [ $1 == "high" ] && echo "$current_per < 80" | ${pkgs.bc}/bin/bc -l | grep -q 1; then
      ${bright} set 80%
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
              ${handle-bright}/bin/handle-bright low
              ;;
            00000001)
              echo plugged in
              echo plugged in >> /tmp/acpi.log
              ${handle-bright}/bin/handle-bright high
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
