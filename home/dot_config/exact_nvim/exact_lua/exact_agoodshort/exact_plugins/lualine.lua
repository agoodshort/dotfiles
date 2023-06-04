return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"kanagawa.nvim",
			{ "someone-stole-my-name/yaml-companion.nvim", dependencies = "neovim/nvim-lspconfig" },
		},
		config = function()
			local function fileloc()
				return vim.fn.getcwd()
			end

			local function codeium()
				return vim.fn["codeium#GetStatusString"]()
			end

			local config = {
				options = {
					disabled_filetypes = { "dashboard", "lspsagaoutline" },
					-- component_separators = "|",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { fileloc },
					lualine_c = { "branch", "diff" },
					lualine_x = { "diagnostics" },
					lualine_y = { "filetype" },
					lualine_z = {
						{
							codeium,
							icon = "",
						},
					},
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

			local function ins_left(component)
				table.insert(config.sections.lualine_y, 1, component)
			end

			-- Lsp server name
			ins_left({
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
				icon = "",
			})

			-- yaml-companion
			local status, schema = pcall(require("yaml-companion").get_buf_schema, 0)
			if status then
				if schema.result[1].name ~= "none" then
					ins_left(schema.result[1].name)
				end
			end

			require("lualine").setup(config)
		end,
	},
	{
		"b0o/incline.nvim",
		dependencies = "nvim-lualine/lualine.nvim",
		opts = {
			render = function(props)
				local fname = vim.fn.expand("%")
				local colors = require("kanagawa.colors").setup()
				local palette_colors = colors.palette

				if props.focused == true then
					return {
						{
							fname,
							guibg = palette_colors.sumiInk0,
							guifg = palette_colors.oldWhite,
						},
					}
				else
					return {
						{
							fname,
							guibg = palette_colors.sumiInk0,
							guifg = palette_colors.sumiInk4,
						},
					}
				end
			end,
		},
	},
}
