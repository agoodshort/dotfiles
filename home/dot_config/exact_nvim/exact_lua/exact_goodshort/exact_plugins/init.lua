return {
	-- simple plugin
	"wakatime/vim-wakatime",
	"sitiom/nvim-numbertoggle",
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

	-- Easymotion like plugin
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup({})
		end,
	}, -- keymaps configured through Which-key

	-- git integration
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"samjwill/nvim-unception",
		config = function()
			vim.g.unception_open_buffer_in_new_tab = true
		end,
	},
}
