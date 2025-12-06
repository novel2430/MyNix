{pkgs, opt-config, ...}:
{
  home.file.".config/wezterm/wezterm.lua" = {
    source = ./wezterm.lua;
  };

  home.file.".config/wezterm/config" = {
    recursive = true;
    source = ./config;
  };

  home.file.".config/wezterm/config/bar.lua" = {
    text = ''
    local M = {}

    local bar_bg = '#${opt-config.colors.terminal-background}'
    local fg = '#${opt-config.colors.foreground}'
    local active_bg = '#${opt-config.colors.focus-background}'
    local inactive_bg = '#${opt-config.colors.terminal-background}'

    M.enable_tab_bar = true
    M.hide_tab_bar_if_only_one_tab = true
    M.use_fancy_tab_bar = false
    M.show_new_tab_button_in_tab_bar = false
    M.tab_bar_at_bottom = false
    M.tab_bar_style = {
      -- The color of the strip that goes along the top of the window
      -- (does not apply when fancy tab bar is in use)
      background = bar_bg,

      -- The active tab is the one that has focus in the window
      active_tab = {
        -- The color of the background area for the tab
        bg_color = active_bg,
        -- The color of the text for the tab
        fg_color = fg,

        -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
        -- label shown for this tab.
        -- The default is "Normal"
        intensity = 'Bold',

        -- Specify whether you want "None", "Single" or "Double" underline for
        -- label shown for this tab.
        -- The default is "None"
        underline = 'None',

        -- Specify whether you want the text to be italic (true) or not (false)
        -- for this tab.  The default is false.
        italic = false,

        -- Specify whether you want the text to be rendered with strikethrough (true)
        -- or not for this tab.  The default is false.
        strikethrough = false,
      },

      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        bg_color = inactive_bg,
        fg_color = fg,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab`.
        intensity = 'Normal',
        underline = 'None',
        italic = false,
        strikethrough = false,
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        bg_color = inactive_bg,
        fg_color = fg,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab_hover`.
        intensity = 'Normal',
        underline = 'Single',
        italic = false,
        strikethrough = false,
      },

      -- The new tab button that let you create new tabs
      -- new_tab = {
      --   bg_color = '#1b1032',
      --   fg_color = '#808080',

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab`.
      -- },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over the new tab button
      -- new_tab_hover = {
      --   bg_color = '#3b3052',
      --   fg_color = '#909090',
      --   italic = true,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab_hover`.
      -- },
    }

    return M
    '';
  };

  home.file.".config/wezterm/config/look.lua" = {
    text = ''
    local my_bar = require("config.bar")
    local M = {}
    local color = {
      fg = '#${opt-config.colors.terminal-foreground}',
      bg = '#${opt-config.colors.terminal-background}',
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
    -- M.need_tab_bar = false
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
      tab_bar = my_bar.tab_bar_style,
    }
    return M
    '';
  };

  home.packages = [
    pkgs.wezterm
  ];
}
