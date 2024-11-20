-- insert all the code from: https://github.com/lukas-reineke/indent-blankline.nvim#multiple-indent-colors
local highlight = {
  "GRAY",
}
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "GRAY", { fg = "#5A5A5A" })
end)
require("ibl").setup { indent = { highlight = highlight } }
