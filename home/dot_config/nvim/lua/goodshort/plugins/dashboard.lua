return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local status_dashboard, dashboard = pcall(require, "dashboard")
		if not status_dashboard then
			return
		end

		dashboard.setup({
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				packages = { enable = true }, -- show how many plugins neovim loaded
				project = { limit = 8, action = "edit" },
				shortcut = {
					{
						desc = " Update",
						group = "@property",
						action = "PackerSync",
						key = "u",
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
		})
	end,
}
