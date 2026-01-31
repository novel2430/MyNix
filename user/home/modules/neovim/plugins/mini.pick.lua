-- Basic Config
require('mini.pick').setup(
-- No need to copy this inside `setup()`. Will be used automatically.
{
  -- Delays (in ms; should be at least 1)
  delay = {
    -- Delay between forcing asynchronous behavior
    async = 10,

    -- Delay between computation start and visual feedback about it
    busy = 50,
  },

  -- Keys for performing actions. See `:h MiniPick-actions`.
  mappings = {
    caret_left  = '<Left>',
    caret_right = '<Right>',

    choose            = '<CR>',
    choose_in_split   = '<C-s>',
    choose_in_tabpage = '<C-t>',
    choose_in_vsplit  = '<C-v>',
    choose_marked     = '<M-CR>',

    delete_char       = '<BS>',
    delete_char_right = '<Del>',
    delete_left       = '<C-u>',
    delete_word       = '<C-w>',

    mark     = '<C-x>',
    mark_all = '<C-a>',

    move_down  = '<C-j>',
    move_start = '<C-g>',
    move_up    = '<C-k>',

    paste = '<C-r>',

    refine        = '<C-Space>',
    refine_marked = '<M-Space>',

    scroll_down  = '<C-f>',
    scroll_left  = '<C-h>',
    scroll_right = '<C-l>',
    scroll_up    = '<C-b>',

    stop = '<Esc>',

    toggle_info    = '<S-Tab>',
    toggle_preview = '<Tab>',
  },

  -- General options
  options = {
    -- Whether to show content from bottom to top
    content_from_bottom = false,

    -- Whether to cache matches (more speed and memory on repeated prompts)
    use_cache = false,
  },

  -- Source definition. See `:h MiniPick-source`.
  source = {
    items = nil,
    name  = nil,
    cwd   = nil,

    match   = nil,
    show    = nil,
    preview = nil,

    choose        = nil,
    choose_marked = nil,
  },

  window = {
    config = function()
      local height = math.floor(vim.o.lines * 0.2)
      local width = vim.o.columns

      -- 预留一点空间，避免压到命令行/状态栏（不同 UI 会有差异）
      local bottom_pad = 0
      local row = vim.o.lines - height - bottom_pad
      if row < 0 then row = 0 end

      return {
        relative = "editor",
        anchor = "NW",
        row = row,
        col = 0,
        width = width,
        height = height,
        border = "none", -- 想要边框就改成 "rounded"/"single"
        style = "minimal",
      }
    end,

    prompt_prefix = '> ',
    prompt_caret = '▏',
  },
})
