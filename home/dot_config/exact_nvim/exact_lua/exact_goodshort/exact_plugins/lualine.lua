return {
	{
		"b0o/incline.nvim",
		dependencies = "goodshort/staline.nvim",
		opts = {},
	},
	{
		"goodshort/staline.nvim",
		branch = "fn_color_invert",
		config = function()
			-- Sets the statusline to full width
			vim.opt.laststatus = 3

			local function fileloc()
				return vim.fn.expand("%:p:.")
			end

			require("staline").setup({
				-- need to add yaml-companion
				sections = {
					left = {
						" ",
						"right_sep",
						"-mode",
						"left_sep",
						" ",
						"right_sep",
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
						"right_sep",
						"-cool_symbol",
						"left_sep",
						" ",
						"right_sep",
						"- ",
						"-lsp_name",
						"- ",
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
		enabled = false,
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

			local colors = {
				blue = "#80a0ff",
				cyan = "#79dac8",
				black = "#080808",
				white = "#c6c6c6",
				red = "#ff5189",
				violet = "#d183e8",
				grey = "#303030",
			}

			local bubbles_theme = {
				normal = {
					a = { fg = colors.black, bg = colors.violet },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.black, bg = colors.black },
				},

				insert = { a = { fg = colors.black, bg = colors.blue } },
				visual = { a = { fg = colors.black, bg = colors.cyan } },
				replace = { a = { fg = colors.black, bg = colors.red } },

				inactive = {
					a = { fg = colors.white, bg = colors.black },
					b = { fg = colors.white, bg = colors.black },
					c = { fg = colors.black, bg = colors.black },
				},
			}

			local config = {
				options = {
					theme = bubbles_theme,
					disabled_filetypes = { "packer", "neo-tree", "lspsagaoutline" },
					component_separators = "|",
					-- section_separators = { left = " ", right = " " },
				},
				sections = {
					lualine_a = { { "mode", separator = { left = "", right = "" } } },
					lualine_b = { { fileloc, separator = { left = "", right = "" } } },
					lualine_c = { "branch", "diff" },
					lualine_x = { "diagnostics" },
					lualine_y = { "filetype" },
					lualine_z = {
						{
							codeium,
							icon = "",
							separator = { right = "" },
							left_padding = 2,
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
					local msg = vim.cmd("call codeium#GetStatusString()")
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
				icon = { "", color = { fg = "green", bg = "black" } },
			})
			-- yaml compagnion
			ins_left({
				function()
					local schema = require("yaml-companion").get_buf_schema(0)
					if schema.result[1].name == "none" then
						return ""
					end
					return schema.result[1].name
				end,
			})

			require("lualine").setup(config)
		end,
	},
}
