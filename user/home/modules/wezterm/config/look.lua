local M = {}
local color = {
  fg = '#cdcecf',
  bg = '#2e3440',
  normal_1 = '#3b4252',
  normal_2 = '#bf616a',
  normal_3 = '#a3be8c',
  normal_4 = '#ebcb8b',
  normal_5 = '#81a1c1',
  normal_6 = '#b48ead',
  normal_7 = '#88c0d0',
  normal_8 = '#e5e9f0',
  bright_1 = '#465780',
  bright_2 = '#d06f79',
  bright_3 = '#b1d196',
  bright_4 = '#f0d399',
  bright_5 = '#8cafd2',
  bright_6 = '#c895bf',
  bright_7 = '#93ccdc',
  bright_8 = '#e7ecf4',
};
M.enable_scroll_bar = false
M.need_tab_bar = false
M.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
M.opacity = 0.9
M.colors = {
  -- The default text color
  foreground = color.fg,
  -- The default background color
  background = color.bg,

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = color.fg,
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = color.bg,
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = color.fg,

  -- the foreground color of selected text
  selection_fg = color.bg,
  -- the background color of selected text
  selection_bg = color.fg,

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#222222',

  -- The color of the split lines between panes
  split = '#444444',
  ansi = {
    color.normal_1,
    color.normal_2,
    color.normal_3,
    color.normal_4,
    color.normal_5,
    color.normal_6,
    color.normal_7,
    color.normal_8,
  },
  brights = {
    color.bright_1,
    color.bright_2,
    color.bright_3,
    color.bright_4,
    color.bright_5,
    color.bright_6,
    color.bright_7,
    color.bright_8,
  },
  --
  -- -- Arbitrary colors of the palette in the range from 16 to 255
  -- indexed = { [136] = '#af8700' },
  --
  -- -- Since: 20220319-142410-0fcdea07
  -- -- When the IME, a dead key or a leader key are being processed and are effectively
  -- -- holding input pending the result of input composition, change the cursor
  -- -- to this color to give a visual cue about the compose state.
  -- compose_cursor = 'orange',
  --
  -- -- Colors for copy_mode and quick_select
  -- -- available since: 20220807-113146-c2fee766
  -- -- In copy_mode, the color of the active text is:
  -- -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- -- 2. selection_* otherwise
  copy_mode_active_highlight_bg = { AnsiColor = 'Yellow' },
  -- -- use `AnsiColor` to specify one of the ansi color palette values
  -- -- (index 0-15) using one of the names "Black", "Maroon", "Green",
  -- --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
  copy_mode_inactive_highlight_bg = { AnsiColor = 'Grey'  },
  copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },
  --
  -- quick_select_label_bg = { Color = 'peru' },
  -- quick_select_label_fg = { Color = '#ffffff' },
  -- quick_select_match_bg = { AnsiColor = 'Navy' },
  -- quick_select_match_fg = { Color = '#ffffff' },
  --
  -- input_selector_label_bg = { AnsiColor = 'Black' }, -- (*Since: Nightly Builds Only*)
  -- input_selector_label_fg = { Color = '#ffffff' }, -- (*Since: Nightly Builds Only*)
}
return M
