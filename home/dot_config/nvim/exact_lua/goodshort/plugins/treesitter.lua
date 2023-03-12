return function()
    local status, treesitter = pcall(require, "nvim-treesitter.configs")
    if not status then
        return
    end

    treesitter.setup({
        highlight = {
            enable = true
        },
        autotag = {
            enable = true,
        },
        indent = { enable = true },
        ensure_installed = {
            "json",
            "javascript",
            "typescript",
            "tsx",
            "yaml",
            "html",
            "css",
            "markdown",
            "markdown_inline",
            "bash",
            "lua",
            "vim",
            "dockerfile",
            "gitignore"
        },
        -- select blocks with <CR>
        auto_install = true,
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                scope_incremental = "<S-CR>",
                node_decremental = "<BS>",
            },
        },
        -- nvim-ts-rainbow
        rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        }
    })
end
