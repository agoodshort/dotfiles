local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
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
packer.init {
    display = {
        open_fn = require('packer.util').float,
    },
    autoremove = true, -- Remove disabled or unused plugins without prompting the users
    snapshot_path = vim.fn.stdpath('config') .. '/lua/goodshort/packer/snapshots' -- Save directory for snapshots
}

-- add list of plugins to install
return packer.startup(function(use)
        -- package manager
        use("wbthomason/packer.nvim")
        use("lewis6991/impatient.nvim")

        -- Simple plugin
        use("dstein64/vim-startuptime")
        use("wakatime/vim-wakatime")
        use { "kwkarlwang/bufresize.nvim", config = require("goodshort.plugins.bufresize") }
        use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end } -- comment with gc
        use { "sitiom/nvim-numbertoggle" }
        use { "alker0/chezmoi.vim" }

        -- theme
        use { "rebelot/kanagawa.nvim", config = require("goodshort.plugins.kanagawa") }
        use { "petertriho/nvim-scrollbar", config = require("goodshort.plugins.scrollbar") }
        use("lukas-reineke/indent-blankline.nvim")
        use {
            'glepnir/dashboard-nvim', event = 'VimEnter', config = require("goodshort.plugins.dashboard"),
            requires = { 'nvim-tree/nvim-web-devicons' }
        }

        -- displays shortcuts
        use { "mrjones2014/legendary.nvim",
            requires = { "stevearc/dressing.nvim", "folke/which-key.nvim" },
            config = require("goodshort.plugins.legendary-whichkey"),
            after = "toggleterm.nvim"
        }

        -- fuzzy-finder w/ telescope
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = "make" }
        use { 'nvim-telescope/telescope-z.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
                'nvim-lua/popup.nvim',
                'nvim-telescope/telescope.nvim',
            }
        }
        use {
            "nvim-telescope/telescope.nvim", branch = "0.1.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "LinArcX/telescope-env.nvim",
                "nvim-telescope/telescope-packer.nvim"
            },
            config = require("goodshort.plugins.telescope"),
        }

        -- treesitter
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
            config = require("goodshort.plugins.treesitter")
        }

        -- auto-closing
        use({ "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end }) -- autoclose parens, brackets, quotes, etc...
        use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags
        use("mrjones2014/nvim-ts-rainbow") -- rainbow parentheses

        --neo-tree
        use {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
                { 's1n7ax/nvim-window-picker', tag = "v1.*" } -- only needed if you want to use the commands with "_with_window_picker" suffix
            },
            config = require("goodshort.plugins.neo-tree")
        }

        -- tabby
        use { "nanozuki/tabby.nvim",
            keys = { [[<C-t>]] }, -- loads when these keys are pressed
            config = require("goodshort.plugins.tabby")
        }

        -- Easymotion like plugin
        use { 'phaazon/hop.nvim', branch = 'v2', config = function() require("hop").setup {} end } -- keymaps configured through Which-key

        -- terminal
        use { "akinsho/toggleterm.nvim", config = require("goodshort.plugins.toggleterm") }

        -- git integration
        use("tpope/vim-fugitive")
        use("tpope/vim-rhubarb")
        use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }

        -- statusline and lsp info
        use({ "j-hui/fidget.nvim", config = require("goodshort.plugins.fidget") })
        use({ 'nvim-lualine/lualine.nvim', after = "kanagawa.nvim", config = require("goodshort.plugins.lualine") })

        -- pretty list for LSP diagnostics
        use { "folke/trouble.nvim",
            requires = "nvim-tree/nvim-web-devicons",
            cmd = { "Trouble", "TroubleToggle" },
            config = require("goodshort.plugins.trouble")
        }

        -- LSP zero
        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v1.x',
            config = require("goodshort.plugins.lsp"),
            requires = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' }, -- Required
                { 'williamboman/mason.nvim' }, -- Optional
                { 'williamboman/mason-lspconfig.nvim' }, -- Optional

                -- Autocompletion
                { 'hrsh7th/nvim-cmp' }, -- Required
                { 'hrsh7th/cmp-nvim-lsp' }, -- Required
                { 'hrsh7th/cmp-buffer' }, -- Optional
                { 'hrsh7th/cmp-path' }, -- Optional
                { 'saadparwaiz1/cmp_luasnip' }, -- Optional
                { 'hrsh7th/cmp-nvim-lua' }, -- Optional

                -- Snippets
                { 'L3MON4D3/LuaSnip' }, -- Required
                { 'rafamadriz/friendly-snippets' }, -- Optional
            }
        }

        -- bootstrapping packer
        if packer_bootstrap then
            require("packer").sync()
        end
    end)
