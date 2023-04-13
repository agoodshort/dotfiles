return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"LinArcX/telescope-env.nvim",
		"barrett-ruth/telescope-http.nvim",
		"jvgrootveld/telescope-zoxide",
		"keyvchan/telescope-find-pickers.nvim",
		"debugloop/telescope-undo.nvim",
		"goodshort/telescope-lazygit-toggleterm.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"AckslD/nvim-neoclip.lua",
	},
	config = function()
		local status_t, telescope = pcall(require, "telescope")
		if not status_t then
			return
		end

		local status_ta, ta = pcall(require, "telescope.actions")
		if not status_ta then
			return
		end

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = ta.move_selection_previous,
						["<C-j>"] = ta.move_selection_next,
						["<C-s>"] = ta.select_vertical,
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
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("env")
		telescope.load_extension("http")
		telescope.load_extension("zoxide")
		telescope.load_extension("find_pickers")
		telescope.load_extension("undo")
		telescope.load_extension("neoclip")
		telescope.load_extension("lazygit_toggleterm")
	end,
}
