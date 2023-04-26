return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		{
			"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
			config = function()
				require("toggle_lsp_diagnostics").init()
			end,
		},
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
		-- local lsp_attach = function(client, bufnr)
		-- 	-- Create your keybindings here...
		-- end

		local lspconfig = require("lspconfig")
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					-- on_attach = lsp_attach,
					capabilities = lsp_capabilities,
				})
			end,
		})

		lspconfig.yamlls.setup({
			settings = {
				yaml = {
					keyOrdering = false,
				},
			},
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
				null_ls.builtins.code_actions.gitsigns,
			},
		})
	end,
}
