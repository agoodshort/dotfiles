return {
	"nanozuki/tabby.nvim",
	event = "TabNew", -- load when new tab is opened
	config = function()
		require("tabby.tabline").use_preset(
			"tab_only",
			{ tab_name = {
				name_fallback = function()
					return ""
				end,
			} }
		)
	end,
}
