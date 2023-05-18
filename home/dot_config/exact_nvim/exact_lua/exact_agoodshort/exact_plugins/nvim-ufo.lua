return {
	{
		"kevinhwang91/nvim-ufo",
		enabled = false,
		lazy = true,
		dependencies = "kevinhwang91/promise-async",
		config = function()
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.o.foldcolumn = "auto" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

			-- lsp->treesitter->indent
			local ftMap = {
				vim = "indent",
				python = { "indent" },
				git = "",
				["neo-tree"] = "",
			}

			local function customizeSelector(bufnr)
				local function handleFallbackException(err, providerName)
					if type(err) == "string" and err:match("UfoFallbackException") then
						return require("ufo").getFolds(providerName, bufnr)
					else
						return require("promise").reject(err)
					end
				end

				return require("ufo")
					.getFolds("lsp", bufnr)
					:catch(function(err)
						return handleFallbackException(err, "treesitter")
					end)
					:catch(function(err)
						return handleFallbackException(err, "indent")
					end)
			end

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return ftMap[filetype] or customizeSelector
				end,
			})
		end,
	},
}
