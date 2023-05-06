return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		theme = "hyper",
		hide = {
			statusline = true, -- hide statusline default is true
			tabline = false, -- hide the tabline
			winbar = true, -- hide winbar
		},
		config = {
			week_header = {
				enable = true,
			},
			packages = { enable = true }, -- show how many plugins neovim loaded
			project = { limit = 8, action = "edit" },
			shortcut = {
				{
					desc = " Lazy",
					group = "@property",
					action = "Lazy",
					key = "l",
				},
				{
					desc = " Files",
					group = "Label",
					action = "Neotree position=current",
					key = "f",
				},
				{
					desc = " Dotfiles",
					group = "DiagnosticHint",
					action = "edit $XDG_CONFIG_HOME",
					key = "d",
				},
				{
					desc = " Configuration",
					group = "Number",
					action = "edit $XDG_CONFIG_HOME/nvim",
					key = "c",
				},
			},
		},
	},
}
