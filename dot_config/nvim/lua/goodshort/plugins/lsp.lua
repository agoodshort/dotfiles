return function()
    -- lsp-zero config --

    -- Learn the keybindings, see :help lsp-zero-keybindings
    -- Learn to configure LSP servers, see :help lsp-zero-api-showcase

    -- Reserve space for diagnostic icons
    vim.opt.signcolumn = 'yes'

    local setup_lsp, lsp = pcall(require, "lsp-zero")
    if not setup_lsp then
        return
    end

    lsp.preset('recommended')

    -- Install these servers
    lsp.ensure_installed({
        'tsserver',
        'eslint',
        'sumneko_lua',
    })

    lsp.set_preferences({
        suggest_lsp_servers = true,
        setup_servers_on_start = true,
        set_lsp_keymaps = true,
        configure_diagnostics = true,
        cmp_capabilities = true,
        manage_nvim_cmp = true,
        call_servers = 'local',
        sign_icons = {
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = ''
        }
    })

    -- remap completion
    local setup_cmp, cmp = pcall(require, "cmp")
    if not setup_cmp then
        return
    end

    local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-j>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<C-k>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    })

    lsp.setup_nvim_cmp({
        mapping = cmp_mappings
    })

    -- Configure lua language server for neovim
    lsp.nvim_workspace()

    lsp.setup()

    -- Reset default vim config
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = true,
    })
end
