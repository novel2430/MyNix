local must_hightlight = {
    "bash",
    "c",
    "cpp",
    "diff",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "java",
    "python",
    "tsx",
    "typescript",
    "nix",
}

require('nvim-treesitter.configs').setup {
  -- ensure_installed = {},
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
}
