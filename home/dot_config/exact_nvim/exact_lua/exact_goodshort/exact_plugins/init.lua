return {
	-- simple plugin
	"wakatime/vim-wakatime",
	"sitiom/nvim-numbertoggle", -- toggles relative number off when leaving buffer
	"alker0/chezmoi.vim",

	{
		"numToStr/Comment.nvim", -- comment with gc
		event = "BufReadPost",
		config = function()
			require("Comment").setup()
		end,
	},

	-- auto-closing --
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	}, -- autoclose parens, brackets, quotes, etc...
	{
		"tiagovla/scope.nvim",
		config = function()
			require("scope").setup()
		end,
	},

	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup({})
		end,
	}, -- keymaps configured through Which-key

	{
		"samjwill/nvim-unception",
		config = function()
			vim.g.unception_open_buffer_in_new_tab = true
		end,
	},
}
