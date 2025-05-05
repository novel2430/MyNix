-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

package.loaded["naughty.dbus"] = {}

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")

-- Error handling
require("config.error_handling").run()

-- Variable definitions
local config_var = require("config.var")
beautiful.init(config_var.beautiful_init)

-- Bar setting
local my_wibox = require("config.my_wibox")
my_wibox.init()

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = config_var.layouts

awful.screen.connect_for_each_screen(function(s)
  s.padding = config_var.screen_padding
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
  -- Tag layout Change Signal
  for _, t in pairs(s.tags) do
    t:connect_signal("property::layout", function()
      my_wibox.layout_widget_update(t)
    end)
    t:connect_signal("property::selected", function()
      my_wibox.layout_widget_update(t)
    end)
  end
  my_wibox.run(s)
end)

-- Key bindings
local my_keys = require("config.my_keys")
my_keys.run()

-- Rules
require("config.my_rules").run(my_keys)

-- Signals
require("config.my_signals").run(my_wibox)

-- Autostart
awful.spawn.once("my-awesome-autostart &")
