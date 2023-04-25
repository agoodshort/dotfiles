return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		lazy = true, -- Might need to comment again if bugs with neo-tree https://github.com/nvim-neo-tree/neo-tree.nvim/issues/828 is resolved
		config = function()
			-- This is where you modify the settings for lsp-zero
			-- Note: autocompletion settings will not take effect

			require("lsp-zero.settings").preset("minimal")
		end,
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp", -- Required
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
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
			-- Here is where you configure the autocompletion settings.
			-- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
			-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

			require("lsp-zero.cmp").extend({
				set_basic_mappings = true,
				set_extra_mappings = true,
				use_luasnip = true,
				set_format = true,
				documentation_window = true,
			})

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")
			local cmp_action = require("lsp-zero.cmp").action()

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
					["<C-j>"] = cmp_action.luasnip_jump_forward(),
					["<C-k>"] = cmp_action.luasnip_jump_backward(),
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig", -- Required
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/nvim-cmp", -- Required
			"williamboman/mason-lspconfig.nvim",

			-- Formatter
			"jose-elias-alvarez/null-ls.nvim",
			"jay-babu/mason-null-ls.nvim",
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{
				"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
				config = function()
					require("toggle_lsp_diagnostics").init()
				end,
			},
		},
		config = function()
			local lsp = require("lsp-zero")

			-- Install these servers
			lsp.ensure_installed({
				"jsonls",
				"lua_ls",
				"tsserver",
				"powershell_es",
				"yamlls",
				"marksman",
			})

			lsp.configure("yamlls", {
				settings = {
					yaml = {
						keyOrdering = false,
					},
				},
			})

			lsp.setup()

			-- null-ls
			local null_ls = require("null-ls")

			local null_opts = lsp.build_options("null-ls", {})

			null_ls.setup({
				-- Creates function `NullFormat` to format only using null_ls
				on_attach = function(client, bufnr)
					null_opts.on_attach(client, bufnr)

					local format_cmd = function(input)
						vim.lsp.buf.format({
							id = client.id,
							timeout_ms = 5000,
							async = input.bang,
						})
					end

					local bufcmd = vim.api.nvim_buf_create_user_command
					bufcmd(bufnr, "NullFormat", format_cmd, {
						bang = true,
						range = true,
						desc = "Format Using Null-ls Only",
					})
				end,
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.beautysh,
					null_ls.builtins.formatting.black,
					null_ls.builtins.diagnostics.cfn_lint,
				},
			})

			-- mason-null-ls
			require("mason-null-ls").setup({
				-- A list of sources to install if they're not already installed.
				-- This setting has no relation with the `automatic_installation setting.
				ensure_installed = { "stylua", "prettier", "beautysh", "black", "cfn_lint" },
				-- Run `require("null-ls).setup.
				-- Will automatically install masons tools based on selected sources in `null-ls.
				-- Can also be an exclusion list.
				-- Example: `automatic_installation = { exclude = { "rust_analyzer, solargraph } }
				automatic_installation = true,
				-- Whether sources that are installed in mason should be automatically set up in null-ls.
				-- Removes the need to set up null-ls manually.
				-- Can either be:
				--  - false: Null-ls is not automatically registered.
				--  - true: Null-ls is automatically registered.
				--  - { types = { SOURCE_NAME = {TYPES} } }. Allows overriding default configuration.
				--  Ex: { types = { eslint_d = {'formatting} } }
				automatic_setup = true,
			})
		end,
	},
}
