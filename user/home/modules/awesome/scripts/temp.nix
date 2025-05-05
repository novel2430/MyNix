{pkgs, ...}:
pkgs.writeShellScriptBin "my-awesome-temp" ''
  CPU_TEMP_1="/sys/class/thermal/thermal_zone0/temp"
  CPU_TEMP_2="/sys/class/hwmon/hwmon1/temp1_input"
  if [ -f "$CPU_TEMP_1" ]; then
      temp_raw=$(cat "$CPU_TEMP_1")
  elif [ -f "$CPU_TEMP_2" ]; then
      temp_raw=$(cat "$CPU_TEMP_2")
  else
      echo "N/A"
      exit 0
  fi
  echo $((temp_raw / 1000))
''
