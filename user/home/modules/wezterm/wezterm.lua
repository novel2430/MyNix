local wezterm = require 'wezterm'
local my_look = require("config.look")
local my_font = require("config.fonts")
local my_settings = require("config.settings")
local my_keys = require("config.keys")
local config = {}

config.colors = my_look.colors
config.font = wezterm.font_with_fallback(my_font.font)
config.font_size = my_font.font_size
config.window_background_opacity = my_look.opacity
config.window_padding = my_look.window_padding
config.enable_tab_bar = my_look.need_tab_bar
config.enable_scroll_bar = my_look.enable_scroll_bar
config.keys = my_keys.keybind
config.key_tables = my_keys.keytable

config.use_ime = my_settings.use_ime
config.term = my_settings.term_var
config.scrollback_lines = my_settings.history_line
config.notification_handling = "NeverShow"
config. warn_about_missing_glyphs = false
return config

