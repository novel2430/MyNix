local on_attach = function(event)
  -- Basic Setting --
  vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "E ",
				[vim.diagnostic.severity.WARN] = "W ",
				[vim.diagnostic.severity.INFO] = "I",
				[vim.diagnostic.severity.HINT] = "H ",
			},
			linehl = {
				[vim.diagnostic.severity.ERROR] = "Error",
				[vim.diagnostic.severity.WARN] = "Warn",
				[vim.diagnostic.severity.INFO] = "Info",
				[vim.diagnostic.severity.HINT] = "Hint",
			},
		},
	})
  local config = {
    -- disable virtual text
    virtual_text = false,
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
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  -- ✅ 关闭 LSP 语义高亮（semantic tokens），但不影响 documentHighlight
  if client then
    client.server_capabilities.semanticTokensProvider = nil
    -- 如果已启动过 semantic tokens，顺手停掉（新版本有这个 API；旧版本 pcall 会忽略）
    pcall(vim.lsp.semantic_tokens.stop, event.buf, client.id)
  end

  -- highlight references of the word under your cursor when your cursor rests there for a little while.
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
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }
  local extra = require("mini.extra")
  -- LSP pickers
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "gi", function()
    extra.pickers.lsp({ scope = "implementation" })
  end, opts)
  map("n", "gr", function()
    extra.pickers.lsp({ scope = "references" })
  end, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "gf", function() vim.lsp.buf.format({ async = true }) end, opts)
  map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  map("n", "[d", function() vim.diagnostic.goto_prev({ border = "rounded" }) end, opts)
  map("n", "]d", function() vim.diagnostic.goto_next({ border = "rounded" }) end, opts)
  map("n", "gl", function() vim.diagnostic.open_float(nil, { focus = false }) end, opts)
  map("n", "<leader>q", vim.diagnostic.setloclist, opts)
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
capabilities.textDocument.completion.completionItem.snippetSupport = false

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
  nil_ls = {
    ['nil'] = {
      formatting = {
        command = { "nixfmt" },
      },
      nix = {
        binary = "nix",
        maxMemoryMB = 2560,
        flake = {
          autoArchive = false,
          autoEvalInputs = false,
          nixpkgsInputName = "nixpkgs",
        },
      },
    },
  },
  -- bashls
  bashls = {},
  -- Rust
  rust_analyzer = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      }
    }
  },
  -- Kotlin
  kotlin_language_server = {},
}

-- Start lspconfig
for server_name, server_config in pairs(lsp_servers) do
  vim.lsp.config(server_name, {
    capabilities = capabilities,
    settings = server_config
  })
  vim.lsp.enable(server_name)
end
