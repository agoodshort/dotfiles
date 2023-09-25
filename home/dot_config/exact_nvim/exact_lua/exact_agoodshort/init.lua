require("agoodshort.set")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- import lazy safely
local status, lazy = pcall(require, "lazy")
if not status then
	return
end

local lazy_defaults = {
	defaults = {
		lazy = false,
		git = {
			url_format = "git@agoodshort.github.com/%s.git",
		},
	},
}

if not vim.g.vscode then
	lazy.setup({
		{ import = "agoodshort.plugins" },
		{ import = "agoodshort.plugins.lsp" },
		{ import = "agoodshort.plugins.navigation" },
		{ import = "agoodshort.plugins.terminal" },
		{ import = "agoodshort.plugins.theme" },
		{ import = "agoodshort.plugins.typing" },
		{ import = "agoodshort.plugins.git" },
	}, lazy_defaults)
else
	lazy.setup({
		{ import = "agoodshort.plugins.navigation.whichkey" },
		{ import = "agoodshort.plugins.vscode" },
	}, lazy_defaults)
	vim.api.nvim_exec(
		[[
    " THEME CHANGER
    function! SetCursorLineNrColorInsert(mode)
        " Insert mode: blue
        if a:mode == "i"
            call VSCodeNotify('nvim-theme.insert')

        " Replace mode: red
        elseif a:mode == "r"
            call VSCodeNotify('nvim-theme.replace')
        endif
    endfunction

    augroup CursorLineNrColorSwap
        autocmd!
        autocmd ModeChanged *:[vV\x16]* call VSCodeNotify('nvim-theme.visual')
        autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.replace')
        autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
        autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
        autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
    augroup END
]],
		false
	)
end
