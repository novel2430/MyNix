-- Open File Jump To Last Postition
vim.cmd([[
  augroup RestoreCursor
    autocmd!
    autocmd BufRead * autocmd FileType <buffer> ++once
      \ let s:line = line("'\"")
      \ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
      \      && index(['xxd', 'gitrebase'], &filetype) == -1
      \ |   execute "normal! g`\""
      \ | endif
  augroup END
]])

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
-- local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
-- if not vim.loop.fs_stat(lazypath) then
--   local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
--   vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
-- end ---@diagnostic disable-next-line: undefined-field
-- vim.opt.rtp:prepend(lazypath)
