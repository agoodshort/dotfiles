-- Big cursor at all time
vim.opt.guicursor = ""

-- Show numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Hightlight cursors line
-- vim.opt.cursorline = true

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

-- Format on save
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- Makes sure that any opened buffer which is contained in a git repo will be tracked
vim.cmd([[autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()]])

-- nvim-unception trick
vim.cmd([[autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete]])

-- Make sure .env.* files get syntax hightlight
vim.cmd([[autocmd BufNewFile,BufRead .env.* set ft=sh]])
vim.cmd([[autocmd BufNewFile,BufRead Brewfile* set ft=sh]])
