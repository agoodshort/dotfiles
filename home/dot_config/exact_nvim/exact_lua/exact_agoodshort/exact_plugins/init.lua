return {
	-- simple plugin
	"wakatime/vim-wakatime",
	"sitiom/nvim-numbertoggle", -- toggles relative number off when leaving buffer
	"alker0/chezmoi.vim",
	{
		"numToStr/Comment.nvim", -- comment with gc
		event = "BufReadPost",
		opts = {},
	},

	-- auto-closing --
	{
		"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...
		opts = {},
	},
	{
		"tiagovla/scope.nvim",
		opts = {},
	},

	{
		"phaazon/hop.nvim",
		branch = "v2",
		opts = {},
	},
	{
		"vuki656/package-info.nvim",
		dependencies = "MunifTanjim/nui.nvim",
		opts = {},
	},

	{
		"samjwill/nvim-unception",
		init = function()
			vim.g.unception_open_buffer_in_new_tab = true
			vim.cmd([[autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete]])

			vim.api.nvim_create_autocmd("User", {
				pattern = "UnceptionEditRequestReceived",
				callback = function()
					-- Toggle the terminal off.
					vim.cmd("9ToggleTerm")
				end,
			})
		end,
	},
}
