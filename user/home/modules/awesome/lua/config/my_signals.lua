local M = {}
local config_var = require("config.var")
local awful = require("awful")
local gears = require("gears")

M.run = function(my_wibox)
  -- Signals
  client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
  end)
  -- Enable sloppy focus, so that focus follows mouse.
  -- client.connect_signal("mouse::enter", function(c)
  --     c:emit_signal("request::activate", "mouse_enter", {raise = false})
  -- end)
  client.connect_signal("focus", function(c)
    c.border_color = config_var.beautiful_init.border_focus
    my_wibox.focus_titlebox.text = config_var.sub_text(c.name) or ""
  end)
  client.connect_signal("unfocus", function(c)
    c.border_color = config_var.beautiful_init.border_normal
    my_wibox.focus_titlebox.text = ""
  end)
  client.connect_signal("property::name", function(c)
    my_wibox.focus_titlebox.text = config_var.sub_text(c.name) or ""
  end)
  -- }}}
end
return M
