local options = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", options)
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
	keymap(value, "<C-f>", ":Telescope live_grep<cr>", options)

	keymap(value, "U", ":redo<cr>", options)
	keymap(value, "L", "10l", options)
	keymap(value, "H", "10h", options)
	keymap(value, "J", "5jzz", options)
	keymap(value, "K", "5kzz", options)
	keymap(value, "Y", "y$", options)

	keymap(value, "<leader>;", "$", options)
	keymap(value, "<leader>j", "o<Esc>cc<Esc>k", options)
	keymap(value, "<leader>k", "O<Esc>cc<Esc>j", options)
	keymap(value, "<BS>", "X", options)

	-- Window Movement --
	keymap(value, "<C-h>", "<C-w>h", options)
	keymap(value, "<C-j>", "<C-w>j", options)
	keymap(value, "<C-k>", "<C-w>k", options)
	keymap(value, "<C-l>", "<C-w>l", options)

	-- Resize with arrows
	keymap(value, "<C-Up>", ":resize -2<CR>", options)
	keymap(value, "<C-Down>", ":resize +2<CR>", options)
	keymap(value, "<C-Left>", ":vertical resize -2<CR>", options)
	keymap(value, "<C-Right>", ":vertical resize +2<CR>", options)
end

-- Stay in indent mode
keymap("v", "<", "<gv", options)
keymap("v", ">", ">gv", options)

-- Paste and keep clipboard item when pasting on top of another motion
keymap("v", "p", '"_dP', options)

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
