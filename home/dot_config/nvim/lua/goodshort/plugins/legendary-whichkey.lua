return function()
    local status, legendary = pcall(require, "legendary")
    if not status then
        return
    end

    local status_wk, wk = pcall(require, "which-key")
    if not status_wk then
        return
    end

    -- automatically register which-key.nvim tables with legendary.nvim
    -- when you register them with which-key.nvim.
    -- `setup()` must be called before `require('which-key).register()`
    legendary.setup({ which_key = { auto_register = true } })
    vim.keymap.set("n", "<C-p>", "<CMD>Legendary find<CR>")


    -- which-key leader config --
    local leader_opts = {
        mode = "n", -- NORMAL mode
        -- prefix: use "<leader>f" for example to map everything related to finding files
        -- the prefix is prepended to every mapping part of `mappings`
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = false, -- use `nowait` when creating keymaps
    }

    local leader2_opts = {
        mode = "n",
        prefix = "<leader><leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
    }

    local blank_opts = {
        mode = "n",
        prefix = "",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
    }

    -- which-key map config --
    local status_telescope, _ = pcall(require, "telescope")
    if status_telescope then
        local telescope_map = {
            f = {
                name = "Telescope", -- optional group name
                f = { "<CMD>Telescope find_files<CR>", "Find Files" },
                g = { "<CMD>Telescope git_files<CR>", "Git Files" },
                b = { "<CMD>Telescope buffers<CR>", "Buffers" },
                h = { "<CMD>Telescope help_tags<CR>", "Help Tags" },
                s = { "<CMD>Telescope grep_string<CR>", "Grep String" },
                l = { "<CMD>Telescope live_grep<CR>", "Live Grep" },
                z = { "<CMD>:lua require'telescope'.extensions.z.list { cmd = { 'zsh', '-ic', 'z -l' } }<CR>", "List z" },
                e = { "<CMD>Telescope env<CR>", "List Environment Variables" },
                p = { "<CMD>Telescope packer<CR>", "List Packer Plugins" },
                t = { "<CMD>Telescope http list<CR>", "List HTTP Status Code" },
            },
        }
        wk.register(telescope_map, leader_opts)
    end

    local fugitive_map = {
        g = {
            name = "Fugitive", -- optional name
            s = { "<CMD>Git<CR>", "Git Status" },
        },
    }

    local toggleterm_map = {
        ["\\"] = { -- map to "\"
            name = "ToggleTerm", -- optional name
            g = { "<CMD>lua _LAZYGIT_TOGGLE()<CR>", "LazyGit" },
            ["\\"] = { "<CMD>ToggleTermToggleAll<CR>", "Toggle All Terminals" },
            ["1"] = { "<CMD>1ToggleTerm<CR>", "Terminal 1" },
            ["2"] = { "<CMD>2ToggleTerm<CR>", "Terminal 2" },
            ["3"] = { "<CMD>3ToggleTerm<CR>", "Terminal 3" }
        },
    }

    -- Trouble keymap --
    local status_trouble, _ = pcall(require, "trouble")
    if status_trouble then
        local trouble_map = {
            x = {
                name = "Trouble", -- optional group name
                x = { "<CMD>TroubleToggle<CR>", "Toggle Trouble" },
                w = { "<CMD>TroubleToggle workspace_diagnostics<CR>", "Workspace Diagnostics" },
                d = { "<CMD>TroubleToggle document_diagnostics<CR>", "Document Diagnostics" },
                q = { "<CMD>TroubleToggle quickfix<CR>", "Quickfix" },
            },
        }
        wk.register(trouble_map, leader_opts)
        wk.register(
            {
                gR = { "<CMD>TroubleToggle lsp_references<CR>", "LSP References" }
            },
            blank_opts)
    end

    -- Hop manual keymap register --
    local status_hop, _ = pcall(require, "hop")
    if status_hop then
        wk.register(
            {
                f = { "<CMD>HopChar1CurrentLineAC<CR>", "Hop Current Line After" },
                F = { "<CMD>HopChar1CurrentLineBC<CR>", "Hop Current Line Before" },
            },
            blank_opts
        )
        wk.register(
            {
                h = { "<CMD>HopChar1AC<CR>", "Hop After" },
                H = { "<CMD>HopChar1BC<CR>", "Hop Before" },
            },
            leader_opts
        )
        wk.register(
            {
                h = { "<CMD>HopChar2MW<CR>", "Hop Anywhere" }
            },
            leader2_opts
        )
    end

    -- Manual personal keymap --
    vim.keymap.set("i", "<C-CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    wk.register(
        {
            q = { "<CMD>:q<CR>", "Close" },
            ["="] = { "<CMD>:lua vim.lsp.buf.format()<CR>", "Format" },
            N = { "<CMD>:lua vim.opt.relativenumber = false<CR>", "Hide Relative Numbers" }
        },
        leader_opts
    )

    -- which-key register calls --
    wk.register(fugitive_map, leader_opts)
    wk.register(toggleterm_map, leader_opts)

    wk.setup()
end
