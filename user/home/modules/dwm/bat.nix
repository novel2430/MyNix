{opt-config, ...}:
{
  home.file.".dwm/bat.py" = {
    text = ''
    import os
    sys_state = {
        "first_start": True,
        "temp_path": None,
        "bat_path": None,
        "interval": 3,
    }
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
            icon = '󰠠'
        else:
            if per >= 80:
                icon = "" # 100 ~ 80
            elif per >= 50: 
                icon = "" # 50 ~ 80
            elif per >= 20: 
                icon = "" # 20 ~ 50
            else: 
                icon = "" # 0 ~ 20

        if status == "Charging":
            return f'%{{F#${opt-config.colors.green}}}{icon} {per}%{{F-}}'
        else: 
            return f'%{{F#${opt-config.colors.foreground}}}{icon} {per}%{{F-}}'

    bat = get_battery()
    print(bat)
    '';
  };
}
