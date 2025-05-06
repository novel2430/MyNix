local M = {}
local awful = require("awful")
local wibox = require("wibox")
local config_var = require("config.var")
local my_widgets = require("config.my_widgets")

-- Create a textclock widget
M.mytextclock = my_widgets.textclock
-- Create a wibox for each screen and add it
M.taglist_buttons = my_widgets.taglist_buttons
-- Focus client name widget
M.focus_titlebox = my_widgets.focus_titlebox
-- CPU widget
M.cpu_widget = my_widgets.cpu_widget
-- RAM widget
M.ram_widget = my_widgets.ram_widget
-- TEMP widget
M.temp_widget = my_widgets.temp_widget
-- Layout widget
M.layout_widget = my_widgets.layout_widget
-- BAT widget
M.bat_widget = my_widgets.bat_widget

M.layout_widget_update = function (t)
  local current_tag = awful.screen.focused().selected_tag
  local logo = config_var.layout_icon.tile
  if current_tag ~= nil and t == current_tag and awful.layout.get_tag_layout_index(current_tag) == 1 then
    -- Tile 
    logo = config_var.layout_icon.tile
  elseif current_tag ~= nil and t == current_tag and awful.layout.get_tag_layout_index(current_tag) == 2 then
    -- Float
    logo = config_var.layout_icon.float
  elseif current_tag ~= nil and t == current_tag and awful.layout.get_tag_layout_index(current_tag) == 3 then
    -- Max
    logo = config_var.layout_icon.max
  end
  M.layout_widget.text = logo
end
M.init = function()
  my_widgets.cpu_widget_watch()
  my_widgets.ram_widget_watch()
  my_widgets.temp_widget_watch()
  my_widgets.bat_widget_update()
end
M.run = function(s)
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen          = s,
    filter          = awful.widget.taglist.filter.all,
    buttons         = M.taglist_buttons,
    layout          = wibox.layout.fixed.horizontal,
    widget_template = {
      {
        {
          id     = "text_role",
          widget = wibox.widget.textbox,
          align  = "center",
        },
        left   = config_var.my_size.taglist_left_spacing,
        right  = config_var.my_size.taglist_right_spacing,
        top    = config_var.my_size.taglist_top_spacing,
        bottom = config_var.my_size.taglist_bottom_spacing,
        widget = wibox.container.margin,
      },
      id     = "background_role",
      widget = wibox.container.background,
    },
  }
  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s
  })
  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      spacing = config_var.my_size.wibox_spacing,
      s.mytaglist,
      M.layout_widget,
      M.focus_titlebox,
    },
    {
      layout = wibox.layout.align.horizontal,
      nil,
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      spacing = config_var.my_size.wibox_spacing,
      M.bat_widget,
      M.temp_widget,
      M.ram_widget,
      M.cpu_widget,
      M.mytextclock,
      wibox.widget.systray(),
    },
  }
end
return M
