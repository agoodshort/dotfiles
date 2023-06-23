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
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
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

			require("mason-null-ls").setup({
				ensure_installed = { "stylua", "prettier", "beautysh", "black", "cfn_lint" },
				automatic_installation = true,
				automatic_setup = true,
			})

			local null_ls = require("null-ls")
			null_ls.setup({
				-- Creates function `NullFormat` to format only using null_ls
				on_attach = function(client, bufnr)
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
		end,
	},
}
