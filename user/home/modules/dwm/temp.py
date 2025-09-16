import os

sys_state = {
    "first_start": True,
    "temp_path": None,
    "bat_path": None,
    "interval": 3,
}

temp_file_1 = "/sys/class/thermal/thermal_zone0/temp"
temp_file_2 = "/sys/class/hwmon/hwmon1/temp1_input"
def get_temperature():
    if sys_state.get("first_start"):
        if os.path.exists(temp_file_1):
            sys_state["temp_path"] = temp_file_1
        elif os.path.exists(temp_file_2):
            sys_state["temp_path"] = temp_file_2

    path = sys_state.get("temp_path")
    if path == None:
        return ""
    try:
        with open(path) as f:
            temp_raw = int(f.read().strip())
    except:
        return ""

    temp_c = temp_raw / 1000

    return f' {temp_c:.0f}°'

temp = get_temperature()

print(temp)
