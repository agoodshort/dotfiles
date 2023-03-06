return function()
    local status_scroll, scrollbar = pcall(require, "scrollbar")
    if not status_scroll then
        return
    end

    scrollbar.setup({
        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
        max_lines = false, -- disables if no. of lines in buffer exceeds this
        hide_if_all_visible = true, -- Hides everything if all lines are visible
        throttle_ms = 100,
        handle = {
            text = " ",
            color = nil,
            color_nr = nil, -- cterm
            highlight = "CursorColumn",
            hide_if_all_visible = true, -- Hides handle if all lines are visible
        },
        marks = {
            Cursor = {
                text = "•",
                priority = 0,
                gui = nil,
                color = nil,
                cterm = nil,
                color_nr = nil, -- cterm
                highlight = "Normal",
            },
            Search = {
                text = { "-", "=" },
                priority = 1,
                gui = nil,
                color = nil,
                cterm = nil,
                color_nr = nil, -- cterm
                highlight = "Search",
            },
            Error = {
                text = { "-", "=" },
                priority = 2,
                gui = nil,
                color = nil,
                cterm = nil,
                color_nr = nil, -- cterm
                highlight = "DiagnosticVirtualTextError",
            },
            Warn = {
                text = { "-", "=" },
                priority = 3,
                gui = nil,
                color = nil,
                cterm = nil,
                color_nr = nil, -- cterm
                highlight = "DiagnosticVirtualTextWarn",
            },
            Info = {
                text = { "-", "=" },
                priority = 4,
                gui = nil,
                color = nil,
                cterm = nil,
                color_nr = nil, -- cterm
                highlight = "DiagnosticVirtualTextInfo",
            },
            Hint = {
                text = { "-", "=" },
                priority = 5,
                gui = nil,
                color = nil,
                cterm = nil,
                color_nr = nil, -- cterm
                highlight = "DiagnosticVirtualTextHint",
            },
            Misc = {
                text = { "-", "=" },
                priority = 6,
                gui = nil,
                color = nil,
                cterm = nil,
                color_nr = nil, -- cterm
                highlight = "Normal",
            },
            GitAdd = {
                text = "┆",
                priority = 7,
                gui = nil,
                color = nil,
                cterm = nil,
                color_nr = nil, -- cterm
                highlight = "GitSignsAdd",
            },
            GitChange = {
                text = "┆",
                priority = 7,
                gui = nil,
                color = nil,
                cterm = nil,
                color_nr = nil, -- cterm
                highlight = "GitSignsChange",
            },
            GitDelete = {
                text = "▁",
                priority = 7,
                gui = nil,
                color = nil,
                cterm = nil,
                color_nr = nil, -- cterm
                highlight = "GitSignsDelete",
            },
        },
        excluded_buftypes = {
            "terminal"
        },
        excluded_filetypes = {
            "prompt",
            "TelescopePrompt",
            "noice",
            "neo-tree"
        },
        autocmd = {
            render = {
                "BufWinEnter",
                "TabEnter",
                "TermEnter",
                "WinEnter",
                "CmdwinLeave",
                "TextChanged",
                "VimResized",
                "WinScrolled",
            },
            clear = {
                "BufWinLeave",
                "TabLeave",
                "TermLeave",
                "WinLeave",
            },
        },
        handlers = {
            cursor = true,
            diagnostic = true,
            gitsigns = false, -- Requires gitsigns
            handle = true,
            search = false, -- Requires hlslens
            ale = false, -- Requires ALE
        },
    })

    -- blankline config --

    local status_bl, blankline = pcall(require, "indent_blankline")
    if not status_bl then
        return
    end

    vim.opt.list = true
    vim.opt.listchars:append "lead:⋅"

    vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

    blankline.setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
        },
    }
end
