local on_attach = function(event)
  -- Basic Setting --
  local signs = {
    { name = "DiagnosticSignError", text = "E" },
    { name = "DiagnosticSignWarn",  text = "W" },
    { name = "DiagnosticSignHint",  text = "H" },
    { name = "DiagnosticSignInfo",  text = "I" },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }
  vim.diagnostic.config(config)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
  -- highlight references of the word under your cursor when your cursor rests there for a little while.
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      callback = vim.lsp.buf.clear_references,
    })
  end
  -- keymap
  local bufnr = event.buf
  local opts = { noremap = true, silent = true }
  local map = function(key, command)
    vim.api.nvim_buf_set_keymap(bufnr, "n", key, command, opts)
  end
  map("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  map("gf", "<cmd>lua vim.lsp.buf.format()<CR>")
  map("gi", "<cmd>Telescope lsp_implementations<CR>")
  map("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  map("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  map("gr", "<cmd>Telescope lsp_references<CR>")
  map("[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>')
  map("gl", "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>")
  map("<leader>d", "<cmd>Telescope lsp_document_symbols<cr>")
  map("]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>')
  map("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
  map("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
end

-- LSP autocmd for attach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
  callback = function(event)
    on_attach(event)
  end,
})

-- LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- LSP Server Config
local lsp_servers = {
  -- Lua Language Server
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
  -- Pyright
  pyright = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
        diagnosticMode = "workspace",
      },
    },
  },
  -- Clangd
  clangd = {},
  -- nil_ls (nix)
  nil_ls = {},
  -- bashls
  bashls = {},
  -- Rust
  rust_analyzer = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      }
    }
  },
}

-- Start lspconfig
for server_name, server_config in pairs(lsp_servers) do
  require('lspconfig')[server_name].setup {
    capabilities = capabilities,
	  settings = server_config
  }
end

-- For Vue (Volar)
require('lspconfig').volar.setup {
  capabilities = capabilities,
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

