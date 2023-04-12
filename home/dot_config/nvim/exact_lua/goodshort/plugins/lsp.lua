return function()
	-- lsp-zero config --

	-- Learn the keybindings, see :help lsp-zero-keybindings
	-- Learn to configure LSP servers, see :help lsp-zero-api-showcase

	-- Reserve space for diagnostic icons
	vim.opt.signcolumn = "yes"

	local setup_lsp, lsp = pcall(require, "lsp-zero")
	if not setup_lsp then
		return
	end

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
        "yamlls"
	})

	-- remap completion
	local setup_cmp, cmp = pcall(require, "cmp")
	if not setup_cmp then
		return
	end

	local cmp_mappings = lsp.defaults.cmp_mappings({
		["<C-j>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["<C-k>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	})

	lsp.setup_nvim_cmp({
		mapping = cmp_mappings,
	})

	-- Configure lua language server for neovim
	lsp.nvim_workspace()

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
		ensure_installed = { "stylua", "prettier", "beautysh" },
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
end
