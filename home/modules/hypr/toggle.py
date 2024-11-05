#! /usr/bin/env python3
import shlex, subprocess
import json

def subprocess_run_no_input(cmd):
    p = subprocess.run(shlex.split(cmd), stdout=subprocess.PIPE)
    res = p.stdout.decode('utf-8')
    return res
def subprocess_run_input(cmd, input):
    p = subprocess.run(shlex.split(cmd), stdout=subprocess.PIPE, input=input.encode())
    res = p.stdout.decode('utf-8')
    return res
class Cliet:
    def __init__(self, title, class_name, addr) -> None:
        self.title = title
        self.class_name = class_name
        self.addr = addr
    def build_string(self):
        res = "[{}] {}".format(self.class_name, self.title)
        return res
# Get all window json
hyprland_clients_cmd = "hyprctl clients -j"
all_cliets_array = json.loads(subprocess_run_no_input(hyprland_clients_cmd))
# build not empty window
clients_array = []
for c in all_cliets_array:
    if c["class"] != "":
        class_name = c["class"]
        title = c["title"]
        addr = c["address"]
        client = Cliet(title, class_name, addr)
        clients_array.append(client)
# build wofi input string
wofi_str = ""
for i in range(len(clients_array)):
    if i > 0:
        wofi_str = wofi_str + "\n"
    wofi_str = wofi_str + clients_array[i].build_string()
# wofi run
wofi_cmd = "wofi --show dmenu -Ddmenu-print_line_num=true"
index = subprocess_run_input(wofi_cmd, wofi_str)
# switch window
hyprctl_cmd = 'hyprctl dispatch focuswindow address:{}'.format(clients_array[int(index)].addr)
subprocess_run_no_input(hyprctl_cmd)
