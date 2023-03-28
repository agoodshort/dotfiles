local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim and installs/updates/removes plugins whenever you save this file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- packer configs
packer.init({
	display = {
		open_fn = require("packer.util").float,
	},
	autoremove = true, -- Remove disabled or unused plugins without prompting the users
	profile = {
		enable = true,
		threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
	},
	snapshot_path = vim.fn.stdpath("config") .. "/lua/goodshort/packer/snapshots", -- Save directory for snapshots
})

-- add list of plugins to install
return packer.startup(function(use)
	-- package manager
	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")

	-- Simple plugin
	use("dstein64/vim-startuptime")
	use("wakatime/vim-wakatime")
	use({ "kwkarlwang/bufresize.nvim", config = require("goodshort.plugins.bufresize") })
	use("sitiom/nvim-numbertoggle")
	use("alker0/chezmoi.vim")

	-- Comments
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				enabled = true, --if you want to disable Neogen
				snippet_engine = "luasnip",
				input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
			})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
		tag = "*", -- folllow only stable versions
	})
	use({
		"numToStr/Comment.nvim", -- comment with gc
		config = function()
			require("Comment").setup()
		end,
	})
	-- theme --
	use({ "rebelot/kanagawa.nvim", commit = "de7fb5f", config = require("goodshort.plugins.kanagawa") })
	use({ "petertriho/nvim-scrollbar", config = require("goodshort.plugins.scrollbar") })
	use("lukas-reineke/indent-blankline.nvim")
	use({
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = require("goodshort.plugins.dashboard"),
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	-- Which-key --
	-- Used to configure keymaps
	-- Can be listed though telescope
	use({ "folke/which-key.nvim", config = require("goodshort.plugins.whichkey") })

	-- telescope --
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"AckslD/nvim-neoclip.lua",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("neoclip").setup()
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"LinArcX/telescope-env.nvim",
			"nvim-telescope/telescope-packer.nvim",
			"barrett-ruth/telescope-http.nvim",
			"jvgrootveld/telescope-zoxide",
			"keyvchan/telescope-find-pickers.nvim",
			"debugloop/telescope-undo.nvim",
			"kdheepak/lazygit.nvim",
		},
		config = require("goodshort.plugins.telescope"),
	})

	-- Treesitter --
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = require("goodshort.plugins.treesitter"),
	})

	-- auto-closing --
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	}) -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags
	use("mrjones2014/nvim-ts-rainbow") -- rainbow parentheses

	-- neo-tree --
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{ "s1n7ax/nvim-window-picker", tag = "v1.*" }, -- only needed if you want to use the commands with "_with_window_picker" suffix
		},
		config = require("goodshort.plugins.neo-tree"),
	})

	-- tabby --
	use({
		"nanozuki/tabby.nvim",
		event = "TabNew", -- load when new tab is opened
		config = require("goodshort.plugins.tabby"),
	})

	-- Easymotion like plugin
	use({
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup({})
		end,
	}) -- keymaps configured through Which-key

	-- terminal
	use({ "akinsho/toggleterm.nvim", config = require("goodshort.plugins.toggleterm") })

	-- git integration
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	use({
		"samjwill/nvim-unception",
		setup = function()
			vim.g.unception_open_buffer_in_new_tab = true
		end,
	})

	-- statusline and lsp info
	use({ "j-hui/fidget.nvim", config = require("goodshort.plugins.fidget") })
	use({ "nvim-lualine/lualine.nvim", after = "kanagawa.nvim", config = require("goodshort.plugins.lualine") })
	use({
		"adoyle-h/lsp-toggle.nvim",
		config = function()
			require("lsp-toggle").setup()
		end,
	})
	use({
		"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
		config = function()
			require("toggle_lsp_diagnostics").init()
		end,
	})
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = require("goodshort.plugins.lspsaga"),
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- pretty list for LSP diagnostics
	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = require("goodshort.plugins.trouble"),
	})

	-- LSP config
	use({
		"goodshort/lsp-zero.nvim",
		-- branch = "v1.x",
		config = require("goodshort.plugins.lsp"),
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Formatter
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "jay-babu/mason-null-ls.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
	})

	-- bootstrapping packer
	if packer_bootstrap then
		require("packer").sync()
	end
end)
