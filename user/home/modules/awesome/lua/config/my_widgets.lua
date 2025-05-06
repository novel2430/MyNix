local M = {}
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local config_var = require("config.var")
local bat0_path = "/sys/class/power_supply/BAT0/"
local bat1_path = "/sys/class/power_supply/BAT1/"
-- help Function
---- Path Exist
local function path_exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  else
    return false
  end
end
---- Read File
local function read_file(path)
  local file = io.open(path, "r")
  if file then
    local value = file:read("*l")
    file:close()
    return value
  else
    return nil
  end
end
---- BAT update
local function bat_update()
  -- Get Correct BAT path
  local base_path = ""
  if path_exists(bat0_path .. "capacity") then
    base_path = bat0_path
  elseif path_exists(bat1_path .. "capacity") then
    base_path = bat1_path
  else
    M.bat_widget.text = ""
    return
  end

  local status = read_file(base_path .. "status") or "Unknown"
  local per = tonumber(read_file(base_path .. "capacity") or "0") or 0
  local icon = "󰁿"

  if status == "Charging" then
    if per >= 90 then
      icon = "󰂅"
    elseif per >= 80 then
      icon = "󰂋"
    elseif per >= 70 then
      icon = "󰂊"
    elseif per >= 60 then
      icon = "󰢞"
    elseif per >= 50 then
      icon = "󰂉"
    elseif per >= 40 then
      icon = "󰢝"
    elseif per >= 30 then
      icon = "󰂈"
    elseif per >= 20 then
      icon = "󰂇"
    elseif per >= 10 then
      icon = "󰂆"
    elseif per < 10 then
      icon = "󰢜"
    end
  else
    if per >= 90 then
      icon = "󰁹"
    elseif per >= 80 then
      icon = "󰂂"
    elseif per >= 70 then
      icon = "󰂁"
    elseif per >= 60 then
      icon = "󰂀"
    elseif per >= 50 then
      icon = "󰁿"
    elseif per >= 40 then
      icon = "󰁾"
    elseif per >= 30 then
      icon = "󰁽"
    elseif per >= 20 then
      icon = "󰁼"
    elseif per >= 10 then
      icon = "󰁻"
    elseif per < 10 then
      icon = "󰂃"
    end
  end

  M.bat_widget.text = icon .. " " .. per .. "%"
end
-- textclock widget
M.textclock = wibox.widget.textclock(" %Y-%m-%d %a %H:%M", 5, "Asia/Shanghai")
-- Taglist Buttons
M.taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end)
)
-- Focus client name widget
M.focus_titlebox = wibox.widget {
  text   = "",
  align  = "center",
  valign = "center",
  widget = wibox.widget.textbox
}
-- CPU widget
M.cpu_widget = wibox.widget {
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox
}
-- CPU widget - Watch Function
M.cpu_widget_watch = function()
  awful.widget.watch(
    [[
      my-awesome-cpu
    ]],
    3,
    function(widget, stdout)
      local cpu_usage = tonumber(stdout) or 0
      widget.text = string.format(" %.1f%%", cpu_usage)
    end,
    M.cpu_widget
  )
end
-- RAM widget
M.ram_widget = wibox.widget {
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox
}
-- RAM widget - Watch Function
M.ram_widget_watch = function()
  awful.widget.watch(
    [[
      sh -c "free | awk '/Mem:/ { printf(\"%.1f\", \$3 / \$2 * 100) }'"
    ]],
    5,
    function(widget, stdout)
      local ram_usage = tonumber(stdout) or 0
      widget.text = string.format(" %.1f%%", ram_usage)
    end,
    M.ram_widget
  )
end
-- TEMP widget
M.temp_widget = wibox.widget {
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox
}
-- TEMP widget - Watch Function
M.temp_widget_watch = function()
  awful.widget.watch(
    [[
      my-awesome-temp
    ]],
    5,
    function(widget, stdout)
      local temp_usage = tonumber(stdout) or 0
      widget.text = string.format(" %d°C", temp_usage)
    end,
    M.temp_widget
  )
end
-- Layout widget
M.layout_widget = wibox.widget {
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
  text = config_var.layout_icon.tile
}
-- BAT widget
M.bat_widget = wibox.widget {
  widget = wibox.widget.textbox,
  align = "center",
  valign = "center"
}
-- BAT widget - Update Function
M.bat_widget_update = function()
  gears.timer {
    timeout = 5,
    autostart = true,
    call_now = true,
    callback = bat_update
  }
end
return M
