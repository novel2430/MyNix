#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
niri_ws_windows.py
- 默认：打印当前活动 workspace 的所有窗口（JSON 数组）
- --count：打印当前 workspace 的窗口数量（纯数字）
- --count-all：打印所有窗口总数（纯数字）
- --waybar：打印 {"text": "...", "tooltip": "..."}（当前 workspace 数量）
- --waybar-all：打印 {"text": "...", "tooltip": "..."}（全部窗口数量）
"""
import json
import subprocess
import sys
from typing import List, Dict, Any


def run_json(cmd: List[str]) -> Any:
    out = subprocess.check_output(cmd, text=True)
    return json.loads(out)


def get_active_workspace_id() -> int:
    workspaces = run_json(["niri", "msg", "--json", "workspaces"])
    if not isinstance(workspaces, list):
        raise RuntimeError("Unexpected workspaces payload (not a list)")
    active = next((ws for ws in workspaces if ws.get("is_active")), None)
    if not active:
        raise RuntimeError("No active workspace found")
    ws_id = active.get("id")
    if ws_id is None:
        raise RuntimeError("Active workspace has no 'id'")
    return int(ws_id)


def get_all_windows() -> List[Dict[str, Any]]:
    windows = run_json(["niri", "msg", "--json", "windows"])
    if not isinstance(windows, list):
        raise RuntimeError("Unexpected windows payload (not a list)")
    return windows


def get_windows_on_workspace(ws_id: int) -> List[Dict[str, Any]]:
    return [w for w in get_all_windows() if w.get("workspace_id") == ws_id]


def print_waybar_json(text: str, tooltip: str = "", alt: str = "", cls: str = "") -> None:
    payload = {"text": text}
    if tooltip:
        payload["tooltip"] = tooltip
    if cls:
        payload["class"] = cls
    # Waybar 需要一行 JSON
    print(json.dumps(payload, ensure_ascii=False))


def main() -> int:
    args = set(sys.argv[1:])

    try:
        if "--count-all" in args or "--waybar-all" in args:
            all_wins = get_all_windows()
            n = len(all_wins)
            if "--waybar-all" in args:
                print_waybar_json(
                    str(n),
                    tooltip=f"Total windows: {n}",
                    alt="all",
                    cls="has-windows" if n > 0 else "no-windows",
                )
            else:
                print(n)
            return 0

        # 以下是“当前工作区”路径
        ws_id = get_active_workspace_id()
        wins = get_windows_on_workspace(ws_id)

        if "--count" in args or "--waybar" in args:
            n = len(wins)
            if "--waybar" in args:
                # 可在 Waybar 里直接显示数字；悬浮可见 tooltip
                print_waybar_json(
                    str(n),
                    tooltip=f"Workspace {ws_id}: {n} window(s)",
                    alt=f"ws{ws_id}",
                    cls="has-windows" if n > 0 else "no-windows",
                )
            else:
                print(n)
            return 0

        # 默认输出当前工作区窗口的 JSON 数组
        print(json.dumps(wins, ensure_ascii=False, indent=2))
        return 0

    except subprocess.CalledProcessError as e:
        print(f"[error] command failed: {' '.join(e.cmd)}\n{e}", file=sys.stderr)
        return 1
    except json.JSONDecodeError as e:
        print(f"[error] JSON parse failed: {e}", file=sys.stderr)
        return 1
    except Exception as e:
        print(f"[error] {e}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
