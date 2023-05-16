-- Big cursor at all time
vim.opt.guicursor = ""

-- Show numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Search settings
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- display things the way I like
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"

-- Needed to display nice colors
vim.opt.termguicolors = true

-- Vim updates faster
vim.opt.updatetime = 250

-- Make sure .env.* files get syntax hightlight
vim.cmd([[autocmd BufNewFile,BufReadPost .env.* set ft=sh]])
vim.cmd([[autocmd BufNewFile,BufReadPost Brewfile* set ft=sh]])
