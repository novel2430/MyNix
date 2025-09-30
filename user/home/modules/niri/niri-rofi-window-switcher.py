#!/usr/bin/env python3
import json, sys, subprocess, shutil

def load_windows():
    # 若从 stdin 有输入，则用 stdin；否则调用 niri
    if not sys.stdin.isatty():
        data = sys.stdin.read().strip()
        if data:
            return json.loads(data)
    # 调用 niri 获取
    out = subprocess.check_output(["niri", "msg", "--json", "windows"], text=True)
    return json.loads(out)

def rofi_select(lines, prompt="Windows"):
    rofi = shutil.which("rofi") or "rofi"
    # -format i 让 rofi 回传所选行的索引，避免解析文本
    cp = subprocess.run(
        [rofi, "-dmenu", "-i", "-p", prompt, "-format", "i", "-theme-str", "window {width: 40%;}"],
        input="\n".join(lines),
        text=True,
        stdout=subprocess.PIPE,
    )
    if cp.returncode != 0 or not cp.stdout.strip():
        return None
    try:
        return int(cp.stdout.strip())
    except ValueError:
        return None

def main():
    wins = load_windows()

    # 排序：已聚焦优先、然后按 workspace、app_id、title
    wins_sorted = sorted(
        wins,
        key=lambda w: (
            0 if w.get("is_focused") else 1,
            w.get("workspace_id", 0),
            (w.get("app_id") or "").lower(),
            (w.get("title") or "").lower(),
        ),
    )

    # 构造 rofi 行
    lines = []
    for w in wins_sorted:
        ws = w.get("workspace_id")
        app = w.get("app_id") or "unknown"
        title = (w.get("title") or "").replace("\n", " ")
        star = "* " if w.get("is_focused") else ""
        lines.append(f"{star}[{app}] {title}")

    if not lines:
        print("No windows found.")
        return

    idx = rofi_select(lines)
    if idx is None:
        return

    chosen = wins_sorted[idx]
    wid = str(chosen["id"])

    # 切换到该窗口
    subprocess.run(["niri", "msg", "action", "focus-window", "--id", wid])

if __name__ == "__main__":
    main()
