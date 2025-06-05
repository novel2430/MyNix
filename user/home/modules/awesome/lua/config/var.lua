local M = {}
local awful = require("awful")
local gears = require("gears")

-- Help Function
---- Sub Text
M.sub_text = function( text )
  if text ~= nil and text:len() > M.text_max_len then
    return text:sub(1, M.text_max_len) .. " .."
  else
    return text
  end
end

M.my_font = "Hack Nerd Font 12"
M.my_color = {
  red = "#bf616aff",
  fg = "#eceff4ff",
  bg = "#2e3440ff",
  high_bg = "#87a96bff",
  sec_bg = "#4c566aff",
}

M.my_size = {
  gap = 0,
  border_width = 2,
  snap_border_width = 10,
  wibox_height = 25,
  wibox_spacing = 15,
  systray_spacing = 2,
  taglist_top_spacing = 3,
  taglist_bottom_spacing = 3,
  taglist_left_spacing = 10,
  taglist_right_spacing = 10,
}
M.modkey = "Mod4"
M.cmd = {
  terminal = "wezterm",
  d_launcher = "rofi -i -show drun",
  r_launcher = "rofi -show run",
  web_browser = "zen-browser",
  volume_up = "my-volume up",
  volume_down = "my-volume down",
  volume_mute = "my-volume mute",
  screenshot = "scrot-screenshot full",
  screenshot_select = "scrot-screenshot select",
  brightness_up = "brightnessctl set +10%",
  brightness_down = "brightnessctl set 10%-",
  lock_screen = "x-lock",
  greenclip_rofi = "greenclip-rofi",
  power_menu = "rofi-power-menu",
  audio_play_pause = "playerctl play-pause",
  audio_next = "playerctl next",
  audio_prev = "playerctl previous",
}
M.beautiful_init = {
  font = M.my_font,
  useless_gap = M.my_size.gap,
  gap_single_client = true,
  border_width = M.my_size.border_width,
  border_normal = M.my_color.bg,
  border_focus = M.my_color.fg,
  -- Wibox
  wibar_height = M.my_size.wibox_height,
  wibar_bg = M.my_color.bg,
  wibar_fg = M.my_color.fg,
  -- Wibox - taglist
  taglist_font = M.my_font,
  taglist_fg_focus = M.my_color.fg,
  taglist_bg_focus = M.my_color.high_bg,
  taglist_fg_urgent = M.my_color.fg,
  taglist_bg_urgent = M.my_color.red,
  taglist_fg_occupied = M.my_color.fg,
  taglist_bg_occupied = M.my_color.sec_bg,
  taglist_fg_empty = M.my_color.fg,
  taglist_bg_empty = M.my_color.bg,
  -- Wibox - systray
  bg_systray = M.my_color.high_bg,
  systray_icon_spacing = M.my_size.systray_spacing,
  -- Hotkeys widget
  hotkeys_font = M.my_font,
  hotkeys_description_font = M.my_font,
  hotkeys_bg = M.my_color.bg,
  hotkeys_fg = M.my_color.fg,
  hotkeys_border_width = M.my_size.border_width,
  hotkeys_border_color = M.my_color.fg,
  hotkeys_modifiers_fg = M.my_color.high_bg,
  hotkeys_label_bg = M.my_color.high_bg,
  hotkeys_label_fg = M.my_color.fg,
  -- Snap
  snap_border_width = M.my_size.snap_border_width,
  snap_bg = M.my_color.high_bg,
  snap_shape = gears.shape.rectangle,
}
M.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.max,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
M.screen_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}
M.layout_icon = {
  tile = "[ ]=",
  float = "[F]=",
  max = "[M]=",
}
M.text_max_len = tonumber(os.getenv('AWESOMEWM_BAR_CLIENT_TITLE_MAX_LEN') or "36") or 36

return M
