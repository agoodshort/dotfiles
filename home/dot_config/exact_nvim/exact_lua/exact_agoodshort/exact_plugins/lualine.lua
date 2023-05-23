return {
	{
		"b0o/incline.nvim",
		dependencies = "nvim-lualine/lualine.nvim",
		opts = {},
	},
	{
		"agoodshort/staline.nvim",
		enabled = false,
		branch = "fn_color_invert",
		dependencies = {
			"kanagawa.nvim",
			{ "someone-stole-my-name/yaml-companion.nvim", dependencies = "neovim/nvim-lspconfig" },
		},
		config = function()
			local function fileloc()
				return vim.fn.expand("%:p:.")
			end

			local function codeium()
				return vim.fn["codeium#GetStatusString"]()
			end

			local function yaml_companion()
				local schema = require("yaml-companion").get_buf_schema(0)
				if schema.result[1].name == "none" then
					return " "
				end
				return schema.result[1].name
			end

			local function lsp_name()
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
			end

			require("staline").setup({
				sections = {
					left = {
						" ",
						"right_sep",
						"-mode",
						"left_sep",
						" ",
						"right_sep",
						"-cool_symbol",
						fileloc,
						"left_sep",
						" ",
						"right_sep",
						"-branch",
						"left_sep",
						" ",
					},
					mid = { "lsp" },
					right = {
						" ",
						"right_sep",
						"- ",
						lsp_name,
						"- ",
						"-lsp",
						"left_sep",
						" ",
						"right_sep",
						yaml_companion,
						"left_sep",
						" ",
						"right_sep",
						"- ",
						codeium,
						"left_sep",
						" ",
					},
				},

				defaults = {
					left_separator = "",
					right_separator = "",
					true_colors = true,
					fn_invert_color = true,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		-- enabled = false,
		dependencies = {
			"kanagawa.nvim",
			{ "someone-stole-my-name/yaml-companion.nvim", dependencies = "neovim/nvim-lspconfig" },
		},
		config = function()
			local function fileloc()
				return vim.fn.expand("%:p:.")
			end

			local function codeium()
				return vim.fn["codeium#GetStatusString"]()
			end

			local config = {
				options = {
					disabled_filetypes = { "dashboard", "neo-tree", "lspsagaoutline" },
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
}