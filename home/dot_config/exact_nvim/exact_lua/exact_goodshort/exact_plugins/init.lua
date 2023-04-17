return {
	-- simple plugin
	"wakatime/vim-wakatime",
	"sitiom/nvim-numbertoggle",
	"alker0/chezmoi.vim",
	"lukas-reineke/indent-blankline.nvim",

	-- Comments
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				enabled = true, --if you want to disable Neogen
				snippet_engine = "luasnip",
				input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
			})
		end,
		dependencies = "nvim-treesitter/nvim-treesitter",
		version = "*", -- folllow only stable versions
	},
	{
		"numToStr/Comment.nvim", -- comment with gc
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
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
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

		-- LSP
		{
			"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
			config = function()
				require("toggle_lsp_diagnostics").init()
			end,
		},
	},
}
