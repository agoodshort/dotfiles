return function()
	local status_wk, wk = pcall(require, "which-key")
	if not status_wk then
		return
	end

	-- which-key leader config --
	local leader_opts = {
		mode = "n", -- NORMAL mode
		-- prefix: use "<leader>f" for example to map everything related to finding files
		-- the prefix is prepended to every mapping part of `mappings`
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	}

	local leader2_opts = {
		mode = "n",
		prefix = "<leader><leader>",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	}

	local blank_opts = {
		mode = "n",
		prefix = "",
		buffer = nil,
		silent = true,
		noremap = true,
		nowait = false,
	}

	-- telescope --
	local status_telescope, _ = pcall(require, "telescope")
	if status_telescope then
		wk.register({
			f = {
				name = "Telescope", -- optional group name
				k = { "<Cmd>Telescope keymaps<CR>", "List Keymaps" },
				f = { "<Cmd>Telescope find_files<CR>", "Find Files" },
				b = { "<Cmd>Telescope buffers<CR>", "Buffers" },
				h = { "<Cmd>Telescope help_tags<CR>", "Help Tags" },
				s = { "<Cmd>Telescope grep_string<CR>", "Grep String" },
				l = { "<Cmd>Telescope live_grep<CR>", "Live Grep" },
				z = { "<Cmd>Telescope zoxide list<CR>", "List z" },
				e = { "<Cmd>Telescope env<CR>", "List Environment Variables" },
				p = { "<Cmd>Telescope packer<CR>", "List Packer Plugins" },
				t = { "<Cmd>Telescope http list<CR>", "List HTTP Status Code" },
				u = { "<Cmd>Telescope undo<CR>", "Visualize Undo Tree" },
				c = { "<Cmd>Telescope neoclip<CR>", "List Clipboard" },
				["?"] = { "<Cmd>Telescope find_pickers<CR>", "List Telescope Pickers" },
			},
		}, leader_opts)

		wk.register({ ["<C-p>"] = { "<Cmd>Telescope keymaps<CR>", "List Keymaps" } }, blank_opts)

		-- fugitive --
		wk.register({
			g = {
				name = "Git Tools", -- optional name
				s = { "<Cmd>Git<CR>", "Fugitive Git Status" },
				f = { "<Cmd>Telescope git_files<CR>", "Telescope Git Files" },
				c = { "<Cmd>Telescope git_commits<CR>", "Telescope Git Commits" },
				g = { "<Cmd>lua _LAZYGIT_TOGGLE()<CR>", "LazyGit" },
				-- g = { "<Cmd>Telescope lazygit<CR>", "LazyGit" },
				u = { "<Cmd>lua _GITUI_TOGGLE()<CR>", "GitUI" },
				b = { "<Cmd>Gitsigns toggle_current_line_blame<CR>", "Gitsigns Blame" },
			},
		}, leader_opts)
	end

	-- toggleterm --
	local status_toggleterm, _ = pcall(require, "toggleterm")
	if status_toggleterm then
		wk.register({
			["\\"] = { -- map to "\"
				name = "ToggleTerm", -- optional name
				["\\"] = { "<Cmd>ToggleTermToggleAll<CR>", "Toggle All Terminals" },
				["1"] = { "<Cmd>1ToggleTerm<CR>", "Terminal 1" },
				["2"] = { "<Cmd>2ToggleTerm<CR>", "Terminal 2" },
				["3"] = { "<Cmd>3ToggleTerm<CR>", "Terminal 3" },
			},
		}, leader_opts)
	end

	-- Trouble keymap --
	local status_trouble, _ = pcall(require, "trouble")
	if status_trouble then
		wk.register({
			x = {
				name = "Trouble", -- optional group name
				x = { "<Cmd>TroubleToggle<CR>", "Toggle Trouble" },
				w = { "<Cmd>TroubleToggle workspace_diagnostics<CR>", "Workspace Diagnostics" },
				d = { "<Cmd>TroubleToggle document_diagnostics<CR>", "Document Diagnostics" },
				q = { "<Cmd>TroubleToggle quickfix<CR>", "Quickfix" },
			},
		}, leader_opts)
		wk.register({
			gR = { "<Cmd>TroubleToggle lsp_references<CR>", "LSP References" },
		}, blank_opts)
	end

	-- neogen --
	local status_neogen, _ = pcall(require, "neogen")
	if status_neogen then
		wk.register({
			d = { "<Cmd>Neogen<CR>", "Generate documentation" },
		}, leader2_opts)
	end

	-- Hop manual keymap register --
	local status_hop, _ = pcall(require, "hop")
	if status_hop then
		wk.register({
			f = { "<Cmd>HopChar1CurrentLineAC<CR>", "Hop Current Line After" },
			F = { "<Cmd>HopChar1CurrentLineBC<CR>", "Hop Current Line Before" },
		}, blank_opts)
		wk.register({
			h = { "<Cmd>HopChar1AC<CR>", "Hop After" },
			H = { "<Cmd>HopChar1BC<CR>", "Hop Before" },
		}, leader_opts)
		wk.register({
			h = { "<Cmd>HopChar2MW<CR>", "Hop Anywhere" },
		}, leader2_opts)
	end

	-- LSP --
	local status_lsp_toggle, _ = pcall(require, "lsp-toggle")
	local status_toggle_lsp_diagnostics, _ = pcall(require, "toggle_lsp_diagnostics")
	local status_lspsaga, _ = pcall(require, "lspsaga")

	if status_toggle_lsp_diagnostics then
		wk.register({
			l = {
				name = "LSP",
				v = { "<Plug>(toggle-lsp-diag-vtext)", "Toggle LSP Virtual Text" },
			},
		}, leader_opts)
	end

	if status_lsp_toggle then
		wk.register({
			l = {
				name = "LSP",
				l = { "<Cmd>ToggleLSP<CR>", "ToggleLSP" },
				n = { "<Cmd>ToggleNullLSP<CR>", "ToggleNullLSP" },
			},
		}, leader_opts)
	end

	if status_lspsaga then
		wk.register({
			l = {
				name = "LSP",
				f = { "<Cmd>Lspsaga lsp_finder<CR>", "Lspsaga Definition Finder" },
				o = { "<Cmd>Lspsaga outline<CR>", "Lspsaga Outline" },
				c = { "<Cmd>Lspsaga code_action<CR>", "Lspsaga Code Action" },
				d = { "<Cmd>Lspsaga show_line_diagnostics<CR>", "Lspsaga Show Line Diagnostics" },
			},
		}, leader_opts)
	end

	-- Null-ls --

	local status_null_ls, _ = pcall(require, "null-ls")
	if status_null_ls then
		wk.register({
			["="] = { "<Cmd>NullFormat<CR>", "Format Using Null-ls Only" },
		}, leader_opts)
	end

	-- Default vim keymaps --
	wk.register({
		n = { "<Cmd>:noh<CR>", "Clear Search Highlight" },
		N = { "<Cmd>lua vim.opt.relativenumber = false<CR>", "Hide Relative Numbers" },
		c = { "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
		["+"] = { "<Cmd>lua vim.lsp.buf.format()<CR>", "Format" },
	}, leader_opts)

	wk.setup()
end
