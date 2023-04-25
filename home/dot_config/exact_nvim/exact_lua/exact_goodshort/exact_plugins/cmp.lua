return {
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			{
				"danymat/neogen",
				config = function()
					require("neogen").setup({
						enabled = true, --if you want to disable Neogen
						snippet_engine = "luasnip",
						input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
					})
				end,
				dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
				version = "*", -- folllow only stable versions
			},
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "buffer", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
				},
				mapping = {
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
			})
		end,
	},
}
