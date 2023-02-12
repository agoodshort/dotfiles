return function()
    local status_dashboard, dashboard = pcall(require, "dashboard")
    if not status_dashboard then
        return
    end

    dashboard.setup({
        theme = 'hyper',
        config = {
            week_header = {
                enable = true,
            },
            packages = { enable = true }, -- show how many plugins neovim loaded
            project = { limit = 8, action = 'edit' },
            shortcut = {
                {
                    desc = ' Update',
                    group = '@property',
                    action = 'PackerSync',
                    key = 'u'
                },
                {
                    desc = ' Files',
                    group = 'Label',
                    action = 'Telescope find_files',
                    key = 'f',
                },
                {
                    desc = ' Apps',
                    group = 'DiagnosticHint',
                    action = 'Telescope app',
                    key = 'a',
                },
                {
                    desc = ' dotfiles',
                    group = 'Number',
                    action = 'edit $HOME/.config/nvim',
                    key = 'd',
                },
            },
        },
    })
end
