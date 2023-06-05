return {
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		lazy = true,
		build = "cd app && npm install && git reset --hard",
	},

	{
		"AckslD/nvim-FeMaco.lua", -- Edit code blocks in Markdown in a separate window
		ft = "markdown",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {},
	},
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "markdown", "orgmode", "neorg" },
		opts = {
			markdown = {
				fat_headline_lower_string = "▔",
			},
		},
	},
}
