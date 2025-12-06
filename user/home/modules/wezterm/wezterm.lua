local wezterm = require 'wezterm'
local my_look = require("config.look")
local my_font = require("config.fonts")
local my_settings = require("config.settings")
local my_keys = require("config.keys")
local my_bar = require("config.bar")
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
config.warn_about_missing_glyphs = false
config.adjust_window_size_when_changing_font_size = false

-- Tab Bar Stuff
config.enable_tab_bar = my_bar.enable_tab_bar
config.hide_tab_bar_if_only_one_tab = my_bar.hide_tab_bar_if_only_one_tab
config.use_fancy_tab_bar = my_bar.use_fancy_tab_bar
config.show_new_tab_button_in_tab_bar = my_bar.show_new_tab_button_in_tab_bar
config.tab_bar_at_bottom = my_bar.tab_bar_at_bottom

return config

