-- Basic Keymap --
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
-- Normal --
-- Highlight search close --
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>e", ":Lex 20<cr>", opts)
-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-Left>", ":bnext<CR>", opts)
keymap("n", "<S-Right>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)
-- Navigate tabs
-- keymap("n", "<A-Right>", ":tabprevious<CR>", opts)
-- keymap("n", "<A-Left>", ":tabNext<CR>", opts)
-- Insert --
keymap("i", "<C-w>", "<ESC>", opts)
keymap("i", "<A-j>", "<Down>", opts)
keymap("i", "<A-k>", "<Up>", opts)
keymap("i", "<A-h>", "<Left>", opts)
keymap("i", "<A-l>", "<Right>", opts)
keymap("i", "<A-f>", "<S-Right>", opts)
keymap("i", "<A-b>", "<S-Left>", opts)
keymap("i", "<A-a>", "<Home>", opts)
keymap("i", "<A-z>", "<End>", opts)
keymap("i", "<A-o", "<ESC>o", opts)
keymap("i", "<A-g>", "<ESC>ggi", opts)
keymap("i", "<A-G>", "<ESC>Gi", opts)
-- Undo & Redo in INSERT MODE
keymap("i", "<C-u>", "<ESC>:undo<CR>i", opts)
keymap("i", "<C-r>", "<ESC>:redo<CR>i", opts)
-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
-- Terminal --
-- Better terminal navigation
keymap("n", "<Leader>t", ":belowright 10split<CR>:term zsh<CR>i", opts)
keymap("t", "<Leader>t", "<C-\\><C-n>:bdelete!<CR>", term_opts)
keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)
keymap("t", "<C-w>", "<C-\\><C-n>", term_opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- Saving file
keymap("n", "<C-s>", ":wall<CR>", opts)
keymap("n", "<C-q>", ":xa<CR>", opts)
keymap("n", "<C-a>", ":qa!<CR>", opts)
keymap("i", "<C-s>", "<ESC>:wall<CR>", opts)
keymap("i", "<C-q>", "<ESC>:xa<CR>", opts)
keymap("i", "<C-a>", "<ESC>:qa!<CR>", opts)
-- Copy & Paste & Replace
-- One Line
keymap("n", "yy", "\"ayy", opts)
keymap("n", "<Leader>y", "\"+yy", opts)
keymap("n", "y", "\"ay", opts)
-- Lines
keymap("v", "y", "\"ay", opts)
keymap("v", "<Leader>y", "\"+y", opts)
-- Paste
keymap("n", "p", "\"ap", opts)
keymap("n", "<Leader>p", "\"+p", opts)
-- Replace
keymap("v", "p", "\"_d\"ap", opts)
-- Telescope
keymap('n', '<leader>fk', '<cmd>Telescope keymaps<CR>', opts)
keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
keymap('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>', opts)
keymap('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>', opts)
keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
keymap('n', '<leader>fn', '<cmd>Telescope current_buffer_fuzzy_find<CR>', opts)
keymap('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>', opts)
