return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	lazy = true, -- Might need to comment again if bugs with neo-tree https://github.com/nvim-neo-tree/neo-tree.nvim/issues/828 is resolved
	dependencies = {
		-- LSP Support
		{
			"neovim/nvim-lspconfig", -- Required
			cmd = "LspInfo",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
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
				{ "glepnir/lspsaga.nvim" },
			},
			config = function()
				-- Reserve space for diagnostic icons
				vim.opt.signcolumn = "yes"

				local lsp = require("lsp-zero")

				lsp.preset({
					name = "minimal",
					-- set_lsp_keymaps = { preserve_mappings = false }, -- This does not overwrite keybindings created through which-key
					set_lsp_keymaps = true,
					manage_nvim_cmp = true,
					suggest_lsp_servers = true,
					call_servers = "local",
				})

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

				-- Restore built-in config for diagnostic
				vim.diagnostic.config({
					virtual_text = true,
					signs = true,
					update_in_insert = false,
					underline = true,
					severity_sort = false,
					float = true,
				})

				-- null-ls
				local setup_null_ls, null_ls = pcall(require, "null-ls")
				if not setup_null_ls then
					return
				end

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
					},
				})

				-- mason-null-ls
				local setup_null_mason, null_mason = pcall(require, "mason-null-ls")
				if not setup_null_mason then
					return
				end
				null_mason.setup({
					-- A list of sources to install if they're not already installed.
					-- This setting has no relation with the `automatic_installation setting.
					ensure_installed = { "stylua", "prettier", "beautysh", "black" },
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

		-- Autocompletion
		{
			"hrsh7th/nvim-cmp", -- Required
			event = "InsertEnter",
			dependencies = "L3MON4D3/LuaSnip",
			config = function()
				-- Here is where you configure the autocompletion settings.
				-- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
				-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

				require("lsp-zero.cmp").extend()

				-- And you can configure cmp even more, if you want to.
				local cmp = require("cmp")
				local cmp_action = require("lsp-zero.cmp").action()

				cmp.setup({
					mapping = {
						["<C-Space>"] = cmp.mapping.complete(),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
						["<C-j>"] = cmp_action.luasnip_jump_forward(),
						["<C-k>"] = cmp_action.luasnip_jump_backward(),
					},
				})
			end,
		},
		"hrsh7th/cmp-buffer", -- Optional
		"hrsh7th/cmp-path", -- Optional
		"saadparwaiz1/cmp_luasnip", -- Optional
		"hrsh7th/cmp-nvim-lua", -- Optional

		-- Snippets
		"rafamadriz/friendly-snippets", -- Optional
	},
}
