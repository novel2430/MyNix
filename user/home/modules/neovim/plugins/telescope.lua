local action = require('telescope.actions')
local config = {
  defaults = {
    prompt_prefix = "> ",
    selection_caret = "> ",
    path_display = { "smart" },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = action.move_selection_next,
        ["<C-k>"] = action.move_selection_previous,
        ["<Down>"] = action.move_selection_next,
        ["<Up>"] = action.move_selection_previous,
        ["<Tab>"] = action.move_selection_previous,
        ["<CR>"] = action.select_default,
        ["<C-q>"] = action.close,
        ["<ESC>"] = action.close,
      },
      n = {
        ["<C-h>"] = "which_key",
        ["j"] = action.move_selection_next,
        ["k"] = action.move_selection_previous,
        ["<Down>"] = action.move_selection_next,
        ["<Up>"] = action.move_selection_previous,
        ["<Tab>"] = action.move_selection_previous,
        ["<CR>"] = action.select_default,
        ["<C-q>"] = action.close,
        ["<ESC>"] = action.close,
      }

    }
  },
  pickers = {
    live_grep = {
      -- disable_devicons = true,
      theme = "dropdown"
    },
    buffers = {
      -- disable_devicons = true,
      theme = "ivy",
      previewer = false,
      layout_config = {
        height = 10,
      },
    },
    search_history = {
      -- disable_devicons = true,
      theme = "ivy",
      previewer = false,
    },
    command_history = {
      -- disable_devicons = true,
      theme = "ivy",
      previewer = false,
    },
    lsp_references = {
      -- disable_devicons = true,
      theme = "dropdown",
    },
    current_buffer_fuzzy_find = {
      theme = "ivy",
      previewer = true,
      layout_config = {
        height = 15,
      },
    },
    diagnostics = {
      -- disable_devicons = true,
      theme = "ivy",
      previewer = false,
      layout_config = {
        height = 10,
      },
    },
    grep_string = {
      -- disable_devicons = true,
      theme = "ivy",
      previewer = true,
      layout_config = {
        height = 15,
      },
    },
    keymaps = {
      -- disable_devicons = true,
      theme = "ivy",
      previewer = true,
      layout_config = {
        height = 15,
      },
    },

  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_ivy(),
    },
  }
}

-- Enable telescope extensions, if they are installed
require('telescope').load_extension('ui-select')

require('telescope').setup(config)
