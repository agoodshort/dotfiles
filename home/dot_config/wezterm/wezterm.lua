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

-- Kanagawa theme
config.force_reverse_video_cursor = true
config.colors = {
	foreground = "#dcd7ba",
	background = "#1f1f28",

	cursor_bg = "#c8c093",
	cursor_fg = "#c8c093",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}

config.window_background_opacity = 0.9

config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
