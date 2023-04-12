local vk = vim.keymap

vim.g.mapleader = " "

-- Escape insert mode
vk.set("i", "<C-c>", "<ESC>")
vk.set("n", "<C-c>", "<ESC>")

-- windows
vk.set("n", "<C-w>n", ":vsplit<CR>") -- open new window vertically
vk.set("n", "<C-w>x", "<C-w>c") -- close current window

-- buffers
vk.set("n", "<C-h>", ":bprevious<CR>")
vk.set("n", "<C-l>", ":bnext<CR>")

-- move highlighted text
vk.set("v", "J", ":m '>+1<CR>gv=gv") -- move up
vk.set("v", "K", ":m '<-2<CR>gv=gv") -- move down

-- up and down centered
vk.set("n", "<C-u>", "<C-u>zz") -- move up
vk.set("n", "<C-d>", "<C-d>zz") -- move down

-- yank to system clipboard
vk.set("n", "<leader>y", '"+y')
vk.set("v", "<leader>y", '"+y')
vk.set("n", "<leader>Y", '"+Y')

-- paste from system clipboard
vk.set("n", "<leader>p", '"+p')
vk.set("v", "<leader>p", '"+p')
vk.set("n", "<leader>P", '"+P')

-- paste by deleting and sending to void buffer
vk.set("n", "<leader><leader>p", '"_dP')
vk.set("v", "<leader><leader>p", '"_dP')

-- delete to void buffer
vk.set("n", "<leader><leader>d", '"_d')
vk.set("v", "<leader><leader>d", '"_d')

-- create new lines and stay at the same position
vk.set("n", "<leader>o", "mzo<ESC>`z")
vk.set("n", "<leader>O", "mzO<ESC>`z")
