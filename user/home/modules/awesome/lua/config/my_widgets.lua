local M = {}
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local config_var = require("config.var")
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
return M
