return {
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
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-media-files.nvim", dependencies = "nvim-lua/popup.nvim" },
		{ "someone-stole-my-name/yaml-companion.nvim", dependencies = "neovim/nvim-lspconfig" },
		{
			"paopaol/telescope-git-diffs.nvim",
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
	},
	config = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = require("telescope.actions").move_selection_previous,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-s>"] = require("telescope.actions").select_vertical,
						["<C-h>"] = require("telescope.actions").which_key,
						["<tab>"] = require("telescope.actions").toggle_selection,
					},
				},
			},
			extensions = {
				undo = {
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
					-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
					filetypes = { "png", "webp", "jpg", "jpeg" },
					-- find command (defaults to `fd`)
					find_cmd = "rg",
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
	end,
}
