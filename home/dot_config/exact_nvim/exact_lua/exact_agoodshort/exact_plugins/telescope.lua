return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"LinArcX/telescope-env.nvim",
			"barrett-ruth/telescope-http.nvim",
			"jvgrootveld/telescope-zoxide",
			"keyvchan/telescope-find-pickers.nvim",
			"debugloop/telescope-undo.nvim",
			"agoodshort/telescope-lazygit-toggleterm.nvim",
			"AckslD/nvim-neoclip.lua",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-node-modules.nvim",
			"tsakirist/telescope-lazy.nvim",
			"paopaol/telescope-git-diffs.nvim",
			"adoyle-h/lsp-toggle.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-media-files.nvim", dependencies = "nvim-lua/popup.nvim" },
			{ "someone-stole-my-name/yaml-companion.nvim", dependencies = "neovim/nvim-lspconfig" },
			{ "nvim-telescope/telescope-file-browser.nvim", dependencies = "nvim-lua/plenary.nvim" },
			{ "agoodshort/scope.nvim", opts = {} },
		},
		config = function()
			local fb_actions = require("telescope._extensions.file_browser.actions")
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-s>"] = actions.select_vertical,
							["<C-?>"] = actions.which_key,
							["<C-c>"] = actions.close,
							["<tab>"] = actions.toggle_selection,
						},
						n = {
							["k"] = actions.move_selection_previous,
							["j"] = actions.move_selection_next,
							["s"] = actions.select_vertical,
							["?"] = actions.which_key,
							["<C-c>"] = actions.close,
							["<tab>"] = actions.toggle_selection,
						},
					},
				},
				extensions = {
					undo = {
						initial_mode = "normal",
						use_delta = true,
						use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
						side_by_side = false,
						diff_context_lines = vim.o.scrolloff,
						entry_format = "state #$ID, $STAT, $TIME",
						mappings = {
							i = {
								["<CR>"] = require("telescope-undo.actions").restore,
							},
						},
					},
					media_files = {
						-- filetypes whitelist
						filetypes = { "png", "webp", "jpg", "jpeg" }, -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
						find_cmd = "rg", -- find command (defaults to `fd`)
					},
					lazy = {
						-- Whether or not to show the icon in the first column
						show_icon = true,
						-- Mappings for the actions
						mappings = {
							open_in_browser = "<C-o>",
							open_in_file_browser = "<M-b>",
							open_in_find_files = "<C-f>",
							open_in_live_grep = "<C-g>",
							open_plugins_picker = "<C-b>", -- Works only after having called first another action
							open_lazy_root_find_files = "<C-r>f",
							open_lazy_root_live_grep = "<C-r>g",
						},
						-- Other telescope configuration options
					},
					package_info = {
						-- Optional theme (the extension doesn't set a default theme)
						theme = "ivy",
					},
					file_browser = {
						initial_mode = "normal",
						grouped = true,
						files = true,
						add_dirs = true,
						depth = 1,
						auto_depth = false,
						select_buffer = true,
						hidden = true,
						hide_parent_dir = false,
						-- collapse_dirs = true, -- if present breaks the config
						prompt_path = false,
						quiet = false,
						display_stat = { date = true, size = true, mode = true },
						hijack_netrw = true,
						use_fd = true,
						git_status = true,
						mappings = {
							["i"] = {
								["<C-c>"] = actions.close,
								["<C-n>"] = fb_actions.create,
								["<S-CR>"] = fb_actions.create_from_prompt,
								["<C-r>"] = fb_actions.rename,
								["<A-m>"] = fb_actions.move,
								["<A-y>"] = fb_actions.copy,
								["<A-d>"] = fb_actions.remove,
								["<C-o>"] = fb_actions.open,
								["<C-g>"] = fb_actions.goto_parent_dir,
								["<C-e>"] = fb_actions.goto_home_dir,
								["<C-w>"] = fb_actions.goto_cwd,
								["<C-t>"] = fb_actions.change_cwd,
								["<C-f>"] = fb_actions.toggle_browser,
								["<C-h>"] = fb_actions.toggle_hidden,
								["<C-a>"] = fb_actions.toggle_all,
								["<bs>"] = fb_actions.backspace,
							},
							["n"] = {
								["c"] = actions.close,
								["n"] = fb_actions.create,
								["r"] = fb_actions.rename,
								["m"] = fb_actions.move,
								["y"] = fb_actions.copy,
								["d"] = fb_actions.remove,
								["o"] = fb_actions.open,
								["g"] = fb_actions.goto_parent_dir,
								["e"] = fb_actions.goto_home_dir,
								["w"] = fb_actions.goto_cwd,
								["t"] = fb_actions.change_cwd,
								["f"] = fb_actions.toggle_browser,
								["h"] = fb_actions.toggle_hidden,
								["a"] = fb_actions.toggle_all,
							},
						},
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("env")
			require("telescope").load_extension("http")
			require("telescope").load_extension("zoxide")
			require("telescope").load_extension("find_pickers")
			require("telescope").load_extension("undo")
			require("telescope").load_extension("neoclip")
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("lazygit_toggleterm")
			require("telescope").load_extension("media_files")
			require("telescope").load_extension("node_modules")
			require("telescope").load_extension("lazy")
			require("telescope").load_extension("git_diffs")
			require("telescope").load_extension("noice")
			require("telescope").load_extension("yaml_schema")
			require("telescope").load_extension("scope")
			require("telescope").load_extension("package_info")
			require("telescope").load_extension("file_browser")
		end,
	},
	{
		"paopaol/telescope-git-diffs.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"sindrets/diffview.nvim",
				dependencies = "nvim-lua/plenary.nvim",
				config = function()
					local actions = require("diffview.actions")
					require("diffview").setup({
						keymaps = {
							view = {
								{
									"n",
									"<leader>e",
									actions.toggle_files,
									{ desc = "Toggle the file panel." },
								},
							},
							file_panel = {
								{
									"n",
									"<leader>e",
									actions.toggle_files,
									{ desc = "Toggle the file panel" },
								},
							},
							file_history_panel = {
								{
									"n",
									"<leader>e",
									actions.toggle_files,
									{ desc = "Toggle the file panel" },
								},
							},
						},
					})
				end,
			},
		},
	},
	{
		"adoyle-h/lsp-toggle.nvim",
		cmd = { "ToggleLSP", "ToggleNullLSP" },
		config = function()
			require("lsp-toggle").setup({
				create_cmds = true, -- Whether to create user commands
				telescope = true, -- Whether to load telescope extensions
			})
		end,
	},
}
