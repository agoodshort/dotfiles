return {
	-- simple plugin
	"wakatime/vim-wakatime",
	"alker0/chezmoi.vim",
	"kmonad/kmonad-vim",
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPost",
		config = function()
			require("colorizer").setup()
		end,
	},
	{ "sitiom/nvim-numbertoggle", event = "BufReadPost" }, -- toggles relative number off when leaving buffer
	{ "numToStr/Comment.nvim", event = "BufReadPost", opts = {} }, -- comment with gc
	{
		"phaazon/hop.nvim",
		branch = "v2",
		event = "BufReadPost",
		opts = {},
	},
	{
		"vuki656/package-info.nvim",
		ft = "json",
		dependencies = "MunifTanjim/nui.nvim",
		opts = {},
	},

	{
		"samjwill/nvim-unception",
		init = function()
			vim.g.unception_open_buffer_in_new_tab = true
			vim.cmd([[autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete]])

			vim.api.nvim_create_autocmd("User", {
				pattern = "UnceptionEditRequestReceived",
				callback = function()
					-- Toggle the terminal off.
					vim.cmd("9ToggleTerm")
				end,
			})
		end,
	},
}
