-- Used to configure keymaps
-- Can be listed through telescope
return {
	"folke/which-key.nvim",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

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

		local leader_opts_visual = {
			mode = "v",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		local leader2_opts = {
			mode = "n",
			prefix = "<leader><leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		local leader2_opts_visual = {
			mode = "v",
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

		-- yank/paste --
		wk.register({
			y = { '"+y', "Yank to System Clipboard" },
			p = { '"+p', "Paste from System Clipboard" },
		}, leader_opts)

		wk.register({
			y = { '"+y', "Yank to System Clipboard" },
			p = { '"+p', "Paste from System Clipboard" },
		}, leader_opts_visual)

		wk.register({
			d = { '"_d', "Delete using Void Buffer" },
			p = { '"_dp', "Paste and Delete using Void Buffer" },
		}, leader2_opts)

		wk.register({
			d = { '"_d', "Delete using Void Buffer" },
			p = { '"_dp', "Paste and Delete using Void Buffer" },
		}, leader2_opts_visual)

		-- neo tree --
		wk.register({
			-- e = {
			-- 	name = "Neo-tree",
			e = { "<Cmd>Neotree toggle<CR>", "List Keymaps" },
			-- },
		}, leader_opts)

		-- telescope --
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
				g = { "<Cmd>Telescope lazygit_toggleterm<CR>", "LazyGit" },
				u = { "<Cmd>lua _GITUI_TOGGLE()<CR>", "GitUI" },
				b = { "<Cmd>Gitsigns toggle_current_line_blame<CR>", "Gitsigns Blame" },
				d = { "<Cmd>DiffviewOpen<CR>", "Diffview" },
			},
		}, leader_opts)

		-- Tab Management --
		wk.register({
			["<C-t>"] = {
				name = "Tabs", -- optional name
				["n"] = { "<Cmd>tabnew<CR>:Dashboard<CR>", "New Tab" },
				["x"] = { "<Cmd>tabclose<CR>", "Close Tab" },
				["l"] = { "<Cmd>tabn<CR>", "Go To Right Tab" },
				["h"] = { "<Cmd>tabp<CR>", "Go To Left Tab" },
			},
		}, blank_opts)
		vim.keymap.set("n", "<C-t>r", ":TabRename ") -- to review

		-- toggleterm --
		wk.register({
			["\\"] = { -- map to "\"
				name = "ToggleTerm", -- optional name
				["\\"] = { "<Cmd>ToggleTermToggleAll<CR>", "Toggle All Terminals" },
				["1"] = { "<Cmd>1ToggleTerm<CR>", "Terminal 1" },
				["2"] = { "<Cmd>2ToggleTerm<CR>", "Terminal 2" },
				["3"] = { "<Cmd>3ToggleTerm<CR>", "Terminal 3" },
			},
		}, leader_opts)

		-- Trouble keymap --
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

		-- neogen --
		wk.register({
			d = { "<Cmd>Neogen<CR>", "Generate documentation" },
		}, leader_opts)

		-- Hop manual keymap register --
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

		-- LSP --
		wk.register({
			l = {
				name = "LSP",
				v = { "<Plug>(toggle-lsp-diag-vtext)", "Toggle LSP Virtual Text" },
			},
		}, leader_opts)

		wk.register({
			l = {
				name = "LSP",
				l = { "<Cmd>ToggleLSP<CR>", "ToggleLSP" },
				n = { "<Cmd>ToggleNullLSP<CR>", "ToggleNullLSP" },
			},
		}, leader_opts)

		wk.register({
			l = {
				name = "LSP",
				f = { "<Cmd>Lspsaga lsp_finder<CR>", "Lspsaga Definition Finder" },
				o = { "<Cmd>Lspsaga outline<CR>", "Lspsaga Outline" },
				c = { "<Cmd>Lspsaga code_action<CR>", "Lspsaga Code Action" },
				d = { "<Cmd>Lspsaga show_line_diagnostics<CR>", "Lspsaga Show Line Diagnostics" },
			},
		}, leader_opts)

		-- Null-ls --
		wk.register({
			["="] = { "<Cmd>NullFormat<CR>", "Format Using Null-ls Only" },
		}, leader_opts)

		-- Default vim keymaps --
		wk.register({
			n = { "<Cmd>:noh<CR>", "Clear Search Highlight" },
			N = { "<Cmd>lua vim.opt.relativenumber = false<CR>", "Hide Relative Numbers" },
			c = { "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			["+"] = { "<Cmd>lua vim.lsp.buf.format()<CR>", "Format" },
		}, leader_opts)

		wk.setup()
	end,
}
