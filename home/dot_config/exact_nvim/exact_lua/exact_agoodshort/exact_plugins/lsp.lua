-- ensure_installed = { "stylua", "prettier", "beautysh", "black", "cfn_lint" },
return {
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "LspAttach",
		config = function()
			vim.diagnostic.config({
				virtual_text = false, -- Disable virtual_text since it's redundant due to lsp_lines.
				virtual_lines = { only_current_line = true },
			})
			vim.diagnostic.config({ virtual_lines = false }, require("lazy.core.config").ns) -- https://github.com/folke/lazy.nvim/issues/620
			require("lsp_lines").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		build = ":MasonUpdate",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"folke/neodev.nvim",
			"kevinhwang91/nvim-ufo",
			"someone-stole-my-name/yaml-companion.nvim",
		},
		config = function()
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"jsonls",
					"lua_ls",
					"tsserver",
					"powershell_es",
					"yamlls",
					"marksman",
				},
			})

			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Add folding capabilities required by ufo.nvim
			lsp_capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			-- local lsp_attach = function(client, bufnr)
			--              -- Create your keybindings here...
			-- end

			require("neodev").setup({})

			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						-- on_attach = lsp_attach,
						capabilities = lsp_capabilities,
					})
				end,

				-- YAML
				["yamlls"] = function()
					-- TODO: Figure out how to call my lsp_attach from inside plugin on_attach
					local yamlconfig = require("yaml-companion").setup({
						settings = {
							yaml = {
								keyOrdering = false,
							},
						},
					})

					yamlconfig["capabilities"] = lsp_capabilities
					lspconfig.yamlls.setup(yamlconfig)
				end,
			})
		end,
	},
	{
		"nvimdev/guard.nvim",
		config = function()
			local ft = require("guard.filetype")

			-- use stylua to format lua files and no linter
			ft("lua"):fmt("stylua")

			-- use lsp to format first then use golines to format
			-- ft('go'):fmt('lsp')
			--     :append('golines')
			--     :lint('golangci')

			-- call setup LAST
			require("guard").setup({
				-- the only option for the setup function
				fmt_on_save = true,
			})
		end,
	},
}
