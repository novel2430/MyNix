vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lua",
    "python",
    "c", "cpp", "h", "hpp",
    "cs",
    "java",
    "javascript", "typescript", "html", "vue", "css", "javascriptreact", "typescriptreact",
  },
  callback = function(args)
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > 200 * 1024 then
      return
    end
    pcall(vim.treesitter.start, args.buf)
  end,
})
