local vk = vim.keymap

vim.g.mapleader = " "

-- ESC
vk.set("i", "<C-c>", "<ESC>") -- Press ESC

-- windows
vk.set("n", "<C-w>n", ":vsplit<CR>") -- open new window vertically
vk.set("n", "<C-w>x", "<C-w>c") -- close current window

-- tabs
-- renaming tab through tabby
vk.set("n", "<C-t>n", ":tabnew<CR>") -- open new tab
vk.set("n", "<C-t>x", ":tabclose<CR>") -- close new tab
vk.set("n", "<C-t>l", ":tabn<CR>") -- go to tab left
vk.set("n", "<C-t>h", ":tabp<CR>") -- go to tab right

-- buffers
vk.set("n", "<C-h>", ":bprevious<CR>")
vk.set("n", "<C-l>", ":bnext<CR>")

-- move highlighted text
vk.set("v", "J", ":m '>+1<CR>gv=gv") -- move up
vk.set("v", "K", ":m '<-2<CR>gv=gv") -- move down

-- up and down centered
vk.set("n", "<C-u>", "<C-u>zz") -- move up
vk.set("n", "<C-d>", "<C-d>zz") -- move down

-- Paste before the cursor
vk.set("n", "p", "P")

-- paste by deleting and sending to void buffer
vk.set("n", "<leader>p", "\"_dP")
vk.set("v", "<leader>p", "\"_dP")

-- yank to system clipboard
vk.set("n", "<leader>y", "\"+y")
vk.set("v", "<leader>y", "\"+y")
vk.set("n", "<leader>Y", "\"+Y")

-- yank to system clipboard
vk.set("n", "<leader>p", "\"+p")
vk.set("v", "<leader>p", "\"+p")
vk.set("n", "<leader>P", "\"+P")

-- delete to void buffer
vk.set("n", "<leader>d", "\"_d")
vk.set("v", "<leader>d", "\"_d")

-- to replace words
vk.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- clear search highlight until next highlight
vk.set("n", "<leader>n", ":noh<CR>")

-- create new lines and stay at the same position
vk.set("n", "<leader>o", "mzo<ESC>`z")
vk.set("n", "<leader>O", "mzO<ESC>`z")
