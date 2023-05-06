return {
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- LuaSnip required
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		-- Recommended
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		-- My own
		"hrsh7th/cmp-nvim-lua",
		{
			"danymat/neogen", -- write documentation
			config = function()
				require("neogen").setup({
					enabled = true, --if you want to disable Neogen
					snippet_engine = "luasnip",
					input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
				})
			end,
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			version = "*", -- folllow only stable versions
		},
		"David-Kunz/cmp-npm",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "npm", keyword_length = 4 },
			},
			mapping = {
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-j>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- they way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-k>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
		})
	end,
}
