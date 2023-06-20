-- Used to configure keymaps
-- Can be listed through telescope
return {
	"folke/which-key.nvim",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")

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

		local blank_opts_visual = {
			mode = "v",
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		local blank_opts_insert = {
			mode = "i",
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		}

		-- ####################################################################
		if not vim.g.vscode then
			-- telescope --
			wk.register({
				B = { "<Cmd>Telescope scope buffers initial_mode=normal<CR>", "All Buffers" },
				b = { "<Cmd>Telescope buffers initial_mode=normal<CR>", "Tabbed Buffers" },
				e = { "<Cmd>Telescope file_browser<CR>", "File Browser" },
				f = {
					name = "Telescope", -- optional group name
					a = { "<Cmd>Telescope lazy<CR>", "List Lazy plugins" },
					c = { "<Cmd>Telescope neoclip<CR>", "List Clipboard" },
					e = { "<Cmd>Telescope env<CR>", "List Environment Variables" },
					f = { "<Cmd>Telescope find_files<CR>", "Find Files" },
					h = { "<Cmd>Telescope help_tags<CR>", "Help Tags" },
					H = { "<Cmd>Telescope noice<CR>", "Noice History" },
					k = { "<Cmd>Telescope keymaps<CR>", "List Keymaps" },
					l = { "<Cmd>Telescope live_grep<CR>", "Live Grep" },
					m = { "<Cmd>Telescope media_files<CR>", "Preview Images" },
					n = { "<Cmd>Telescope node_modules list<CR>", "List Node Modules" },
					N = { "<Cmd>Telescope package_info<CR>", "Package Info" },
					s = { "<Cmd>Telescope grep_string<CR>", "Grep String" },
					t = { "<Cmd>Telescope http list<CR>", "List HTTP Status Code" },
					u = { "<Cmd>Telescope undo<CR>", "Visualize Undo Tree" },
					z = { "<Cmd>Telescope zoxide list<CR>", "List z" },
					["?"] = { "<Cmd>Telescope find_pickers<CR>", "List Telescope Pickers" },
				},
			}, leader_opts)

			wk.register({ ["<C-p>"] = { "<Cmd>Telescope keymaps<CR>", "List Keymaps" } }, blank_opts)

			-- Git --
			wk.register({
				gg = {
					name = "Git Tools", -- optional name
					f = { "<Cmd>Telescope git_files<CR>", "Telescope Git Files" },
					c = { "<Cmd>Telescope git_commits<CR>", "Telescope Git Commits" },
					g = { "<Cmd>Telescope lazygit_toggleterm<CR>", "LazyGit" },
					u = { "<Cmd>lua _GITUI_TOGGLE()<CR>", "GitUI" },
					b = { "<Cmd>Gitsigns toggle_current_line_blame<CR>", "Gitsigns Blame" },
					d = { "<Cmd>Telescope git_diffs diff_commits<CR>", "Diffview" },
				},
			}, leader_opts)

			-- Tab Management --
			wk.register({
				["<C-t>"] = {
					name = "Tabs",
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
					name = "ToggleTerm",
					["\\"] = { "<Cmd>ToggleTermToggleAll<CR>", "Toggle All Terminals" },
					["1"] = { "<Cmd>1ToggleTerm<CR>", "Terminal 1" },
					["2"] = { "<Cmd>2ToggleTerm<CR>", "Terminal 2" },
					["3"] = { "<Cmd>3ToggleTerm<CR>", "Terminal 3" },
				},
			}, leader_opts)
			wk.register({
				["\\"] = { -- map to "\"
					name = "ToggleTerm",
					["1"] = { "<Cmd>ToggleTermSendVisualLines<CR>", "Send to Terminal 1" },
					["2"] = { "<Cmd>ToggleTermSendVisualLines 2<CR>", "Send to Terminal 2" },
					["3"] = { "<Cmd>ToggleTermSendVisualLines 3<CR>", "Send to Terminal 3" },
				},
			}, leader_opts_visual)

			-- vim-doge --
			wk.register({
				d = { "<Cmd>DogeGenerate<CR>", "Generate documentation" },
			}, leader_opts)

			-- incline --
			wk.register({
				i = { "<Cmd>lua require('incline').toggle()<CR>", "Toggle Incline" },
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
					c = { "<Cmd>Lspsaga code_action<CR>", "Lspsaga Code Action" },
					f = { "<Cmd>Lspsaga lsp_finder<CR>", "Lspsaga Definition Finder" },
					l = { "<Cmd>ToggleLSP<CR>", "ToggleLSP" },
					n = { "<Cmd>ToggleNullLSP<CR>", "ToggleNullLSP" },
					v = { "<Cmd>lua require('lsp_lines').toggle()<CR>", "Toggle LSP Virtual Text" },
					o = { "<Cmd>Lspsaga outline<CR>", "Lspsaga Outline" },
					r = { "<Cmd>Lspsaga rename<CR>", "Lspsaga Rename" },
					d = {
						name = "Diagnostics",
						c = { "<Cmd>Lspsaga show_cursor_diagnostics<CR>", "Lspsaga Show Cursor Diagnostics" },
						l = { "<Cmd>Lspsaga show_line_diagnostics<CR>", "Lspsaga Show Line Diagnostics" },
						b = { "<Cmd>Lspsaga show_buffer_diagnostics<CR>", "Lspsaga Show Buffer Diagnostics" },
						w = { "<Cmd>Lspsaga show_workspace_diagnostics<CR>", "Lspsaga Show Workspace Diagnostics" },
					},
				},
				g = {
					p = { "<Cmd>Lspsaga peek_definition<CR>", "Lspsaga Peek Definition" },
					d = { "<Cmd>Lspsaga goto_definition<CR>", "Lspsaga Go to Definition" },
					t = { "<Cmd>Lspsaga peek_type_definition<CR>", "Lspsaga Peek Type Definition" },
				},
			}, leader_opts)

			wk.register({
				K = { "<Cmd>Lspsaga hover_doc<CR>", "Lspsaga Hover Doc" },
			}, blank_opts)

			-- Null-ls --
			wk.register({
				["="] = { "<Cmd>NullFormat<CR>", "Format Using Null-ls Only" },
			}, leader_opts)

			-- Undotree --
			wk.register({
				["u"] = { "<Cmd>UndotreeToggle<CR>", "Undotree" },
			}, leader_opts)

			-- Codeium --
			wk.register({
				["<C-l>"] = { "<Cmd>call codeium#CycleCompletions(1)<CR>", "Codeium next" },
				["<C-h>"] = { "<Cmd>call codeium#CycleCompletions(-1)<CR>", "Codeium previous" },
				["<S-Tab>"] = { "<Cmd>call codeium#Clear()<CR>", "Codeium clear" },
			}, blank_opts_insert)

			-- NPM Package Info --
			wk.register({
				n = {
					name = "NPM Package Info",
					s = { "<Cmd>lua require('package-info').toggle()<CR>", "Show" },
					d = { "<Cmd>PackageInfoDelete<CR>", "Delete" },
					v = { "<Cmd>PackageInfoChangeVersion<CR>", "Change Version" },
					i = { "<Cmd>PackageInfoInstall<CR>", "Install" },
				},
			}, leader_opts)
		end

		-- ####################################################################

		-- Default vim keymaps --
		wk.register({
			N = { "<Cmd>lua vim.opt.relativenumber = false<CR>", "Hide Relative Numbers" },
			["+"] = { "<Cmd>lua vim.lsp.buf.format()<CR>", "Format" },
			["/"] = { "<Cmd>:noh<CR>", "Clear Search Highlight" },
		}, leader_opts)

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
			d = { '"_dd', "Delete using Void Buffer" },
			p = { '"_dP', "Paste and Delete using Void Buffer" },
		}, leader2_opts)

		wk.register({
			d = { '"_d', "Delete using Void Buffer" },
			p = { '"_dP', "Paste and Delete using Void Buffer" },
		}, leader2_opts_visual)

		-- windows
		wk.register({
			["<C-w>"] = { -- map to "\"
				["n"] = { "<Cmd>vsplit<CR>", "Open New Window vertically" },
				["x"] = { "<C-w>c", "Close Current Window" },
			},
		}, blank_opts)

		-- buffers
		wk.register({
			["<C-h>"] = { "<Cmd>bprevious<CR>", "Previous buffer" },
			["<C-l>"] = { "<Cmd>bnext<CR>", "Next buffer" },
		}, blank_opts)

		-- Create line and stay at same position
		wk.register({
			["o"] = { "mzo<ESC>`z", "Create line below" },
			["O"] = { "mzO<ESC>`z", "Create line above" },
		}, leader_opts)

		-- Move highlighted text
		wk.register({
			["J"] = { ":m '>+1<CR>gv=gv", "Move Text to Next line" },
			["K"] = { ":m '<-2<CR>gv=gv", "Move Text to Previous line" },
		}, blank_opts_visual)

		-- Up and down centered
		wk.register({
			["<C-u>"] = { "<C-u>zz", "Move up centered" },
			["<C-d>"] = { "<C-d>zz", "Move down centered" },
		}, blank_opts)

		-- Escape
		wk.register({
			["<C-c>"] = { "<ESC>", "Escape" },
		}, blank_opts)
		wk.register({
			["<C-c>"] = { "<ESC>", "Escape" },
		}, blank_opts_insert)

		wk.setup()
	end,
}
