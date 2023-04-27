return {
	"nvim-lualine/lualine.nvim",
	dependencies = "kanagawa.nvim",
	config = function()
		local status_lualine, lualine = pcall(require, "lualine")
		if not status_lualine then
			return
		end

		local function fileloc()
			return vim.fn.expand("%:p:.")
		end

		local config = {
			options = {
				theme = "auto",
				disabled_filetypes = { "packer", "neo-tree", "lspsagaoutline" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { fileloc },
				lualine_c = { "branch", "diff" },
				lualine_x = {},
				lualine_y = { "diagnostics" },
				lualine_z = { "filetype" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		}

		local function ins_right(component)
			table.insert(config.sections.lualine_y, component)
		end

		ins_right({
			-- Lsp server name
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = " LSP:",
		})

		lualine.setup(config)
	end,
}
