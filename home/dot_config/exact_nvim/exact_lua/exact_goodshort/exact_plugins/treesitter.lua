return {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		ts_update()
	end,
	event = "BufRead",
	dependencies = { "HiPhish/nvim-ts-rainbow2", "windwp/nvim-ts-autotag" }, --autoclose tags
	config = function()
		local status, treesitter = pcall(require, "nvim-treesitter.configs")
		if not status then
			return
		end

		treesitter.setup({
			highlight = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
			indent = { enable = true },
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
			},
			-- select blocks with <CR>
			auto_install = true,
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<S-CR>",
					node_decremental = "<BS>",
				},
			},
			-- nvim-ts-rainbow
			rainbow = {
				enable = true,
				-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
				-- Which query to use for finding delimiters
				query = "rainbow-parens",
				-- Highlight the entire buffer all at once
				strategy = require("ts-rainbow").strategy.global,
			},
		})
	end,
}
