return function()
    local status_t, telescope = pcall(require, "telescope")
    if not status_t then
        return
    end

    local status_ta, ta = pcall(require, "telescope.actions")
    if not status_ta then
        return
    end

    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-k>"] = ta.move_selection_previous,
                    ["<C-j>"] = ta.move_selection_next,
                }
            }
        }
    })
    telescope.load_extension("fzf")
    telescope.load_extension("env")
    telescope.load_extension("packer")
    telescope.load_extension("http")
    telescope.load_extension("zoxide")
    telescope.load_extension("find_pickers")
end
