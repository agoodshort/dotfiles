require("agoodshort.set")

if vim.g.vscode then
	-- VSCode extension
else
	-- ordinary Neovim
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

	lazy.setup(
		"agoodshort.plugins",
		{ defaults = {
			lazy = false,
			git = {
				url_format = "git@agoodshort.github.com/%s.git",
			},
		} }
	)
end
