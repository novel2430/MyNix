{pkgs, ...}:

pkgs.writers.writePython3Bin "waybar-modules-temp" {
  libraries = [ ];
  flakeIgnore = [ "E302" "E722" "W291" "E303" "E305"];
} ''
import os
import json

def read_temp(path):
    try:
        with open(path, 'r') as f:
            temp_str = f.read().strip()
            return int(temp_str) / 1000.0
    except Exception:
        return None

def main():
    temp_paths = [
        "/sys/class/thermal/thermal_zone0/temp",
        "/sys/class/hwmon/hwmon1/temp1_input"
    ]
    for path in temp_paths:
        if os.path.exists(path):
            temp = read_temp(path)
            temp_class = "custom-temperature"
            if temp is not None:
                print(json.dumps({
                    "text": f" {temp:.1f}°",
                    "tooltip": f"Temperature {temp:.1f}°C",
                    "class": f"{temp_class}",
                    "percentage": int(temp) 
                }))
                return
    pass

if __name__ == "__main__":
    main()
''
