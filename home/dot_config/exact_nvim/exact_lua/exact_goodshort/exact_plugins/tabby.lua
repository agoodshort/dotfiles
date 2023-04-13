return {
	"nanozuki/tabby.nvim",
	-- event = "TabNew", -- load when new tab is opened
	config = function()
		local status, tabline = pcall(require, "tabby.tabline")
		if not status then
			return
		end

		tabline.use_preset("tab_only", { tab_name = {
			name_fallback = function()
				return ""
			end,
		} })
	end,
}
