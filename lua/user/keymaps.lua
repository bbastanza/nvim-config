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
--   visual_mode = "v",
--   visual_block_mode = "x",
--   insert_mode = "i",
--   term_mode = "t",
--   command_mode = "c",

-- Loop through x,v,n to assign common
local repeated = { "x", "v", "n" }

for _, value in pairs(repeated) do
	keymap(value, "<C-f>", ":Telescope live_grep<cr>", opts)

	keymap(value, "U", ":redo<cr>", opts)
	keymap(value, "L", "10l", opts)
	keymap(value, "H", "10h", opts)
	keymap(value, "J", "5jzz", opts)
	keymap(value, "K", "5kzz", opts)
	keymap(value, "Y", "y$", opts)
	keymap(value, "<leader>c", "~h", opts)

	keymap(value, "<leader>;", "$", opts)
	keymap(value, "<leader>j", "o<Esc>cc<Esc>k", opts)
	keymap(value, "<leader>k", "O<Esc>cc<Esc>j", opts)
	keymap(value, "<BS>", "X", opts)

	-- Window Movement --
	keymap(value, "<C-h>", "<C-w>h", opts)
	keymap(value, "<C-j>", "<C-w>j", opts)
	keymap(value, "<C-k>", "<C-w>k", opts)
	keymap(value, "<C-l>", "<C-w>l", opts)

	-- Resize with arrows
	keymap(value, "<C-Up>", ":resize -2<CR>", opts)
	keymap(value, "<C-Down>", ":resize +2<CR>", opts)
	keymap(value, "<C-Left>", ":vertical resize -2<CR>", opts)
	keymap(value, "<C-Right>", ":vertical resize +2<CR>", opts)
end

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Paste and keep clipboard item when pasting on top of another motion
keymap("v", "p", '"_dP', opts)

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
