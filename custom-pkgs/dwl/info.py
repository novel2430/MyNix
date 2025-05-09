import os
import time
from datetime import datetime

sys_state = {
    "first_start": True,
    "temp_path": None,
    "bat_path": None,
    "interval": 3,
}

def get_cpu_usage():
    with open("/proc/stat", "r") as f:
        line = f.readline()
    parts = list(map(int, line.strip().split()[1:]))
    idle = parts[3]
    total = sum(parts)
    return idle, total

def get_memory_usage():
    meminfo = {}
    with open("/proc/meminfo") as f:
        for line in f:
            key, value = line.split(":")
            meminfo[key.strip()] = int(value.strip().split()[0])  # in kB
    total = meminfo["MemTotal"]
    available = meminfo.get("MemAvailable", meminfo["MemFree"])
    used_percent = 100 * (total - available) / total
    return round(used_percent, 1)

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

    return f" {temp_c:.0f}°"


bat0_path = "/sys/class/power_supply/BAT0/"
bat1_path = "/sys/class/power_supply/BAT1/"
def get_battery():
    if sys_state.get("first_start"):
        if os.path.exists(bat0_path):
            sys_state["bat_path"] = bat0_path
        elif os.path.exists(bat1_path):
            sys_state["bat_path"] = bat1_path

    path = sys_state.get("bat_path")
    if path == None:
        return ""

    try:
        with open(f"{path}/capacity") as f:
            per = int(f.read().strip())
        with open(f"{path}/status") as f:
            status = f.read().strip()
    except:
        return ""

    if status == "Charging":
        icon = "󰠠"
    else:
        if per >= 80:
            icon = "" # 100 ~ 80
        elif per >= 50: 
            icon = "" # 50 ~ 80
        elif per >= 20: 
            icon = "" # 20 ~ 50
        else: 
            icon = "" # 0 ~ 20


    return f"{icon} {per}"


prev_idle, prev_total = get_cpu_usage()

sleep_time = sys_state.get("interval")
if sleep_time == None:
    sleep_time = 3

while True:
    if sys_state.get("first_start"):
        time.sleep(1)

    idle, total = get_cpu_usage()
    delta_idle = idle - prev_idle
    delta_total = total - prev_total
    cpu_usage = 100 * (1 - delta_idle / delta_total)
    prev_idle, prev_total = idle, total

    # RAM
    ram_usage = get_memory_usage()

    # Time
    now = datetime.now().strftime(" %Y-%m-%d %a %H:%M")

    output = f" {ram_usage:.1f}| {cpu_usage:.1f}|{now}"

    temp = get_temperature()
    bat = get_battery()
    if temp != "":
        output = f"{temp}|{output}"
    if bat != "":
        output = f"{bat}|{output}"

    output = f" {output}"

    print(output, end="", flush=True)

    sys_state["first_start"] = False

    time.sleep(sleep_time)
