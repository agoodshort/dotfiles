return {
	"serenevoid/kiwi.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	opts = {
		{
			name = "personal",
			path = vim.fn.expand("$HOME/Coding/Personal/wiki"),
		},
		{
			name = "work",
			path = vim.fn.expand("$HOME/Coding/GNH/wiki"),
		},
	},
}
