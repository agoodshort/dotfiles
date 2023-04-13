return {
	"kwkarlwang/bufresize.nvim",
	config = function()
		local status_bufresize, bufresize = pcall(require, "bufresize")
		if not status_bufresize then
			return
		end

		local opts = { noremap = true, silent = true }
		bufresize.setup({
			register = {
				keys = {
					{ "n", "<C-w><", "30<C-w><", opts },
					{ "n", "<C-w>>", "30<C-w>>", opts },
					{ "n", "<C-w>+", "10<C-w>+", opts },
					{ "n", "<C-w>-", "10<C-w>-", opts },
					{ "n", "<C-w>_", "<C-w>_", opts },
					{ "n", "<C-w>=", "<C-w>=", opts },
					{ "n", "<C-w>|", "<C-w>|", opts },
					{ "", "<LeftRelease>", "<LeftRelease>", opts },
					{ "i", "<LeftRelease>", "<LeftRelease><C-o>", opts },
				},
				trigger_events = { "BufWinEnter", "WinEnter" },
			},
			resize = {
				keys = {},
				trigger_events = { "VimResized" },
				increment = false,
			},
		})
	end,
}
