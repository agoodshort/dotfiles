-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Set keybindings
-- Use  `wezterm show-keys --lua` to see current keybindings
local act = wezterm.action
config.keys = {
	{
		key = "F",
		mods = "SHIFT|CTRL",
		action = act.Search({ CaseInSensitiveString = "" }),
	},
	{
		key = "U",
		mods = "SHIFT|CTRL",
		action = act.ScrollByPage(-0.5),
	},
	{
		key = "D",
		mods = "SHIFT|CTRL",
		action = act.ScrollByPage(0.5),
	},
}

-- Used with indent-blankline.nvim scope
config.underline_thickness = 2
config.underline_position = -3

-- Theme
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.9
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
