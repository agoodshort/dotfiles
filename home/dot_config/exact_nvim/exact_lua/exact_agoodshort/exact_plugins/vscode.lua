return {
	{
		"asvetliakov/vim-easymotion",
		cond = function()
			if not vim.g.vscode then
				return false
			else
				return true
			end
		end,
		config = function()
			vim.g.EasyMotion_do_mapping = 0
			vim.g.EasyMotion_smartcase = 1
			vim.keymap.set("n", "f", "<Plug>(easymotion-fl)")
			vim.keymap.set("n", "F", "<Plug>(easymotion-Fl)")
			vim.keymap.set("n", "<Leader>h", "<Plug>(easymotion-f)")
			vim.keymap.set("n", "<Leader>H", "<Plug>(easymotion-F)")
			vim.keymap.set("n", "<Leader><Leader>h", "<Plug>(easymotion-bd-f2)")
		end,
	},
}
