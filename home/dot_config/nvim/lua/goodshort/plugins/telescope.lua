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
        },
        extensions = {
            undo = {
                use_delta = true,
                use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
                side_by_side = false,
                diff_context_lines = vim.o.scrolloff,
                entry_format = "state #$ID, $STAT, $TIME",
                mappings = {
                    i = {
                        -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
                        -- you want to replicate these defaults and use the following actions. This means
                        -- installing as a dependency of telescope in it's `requirements` and loading this
                        -- extension from there instead of having the separate plugin definition as outlined
                        -- above.
                        ["<cr>"] = require("telescope-undo.actions").yank_additions,
                        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-cr>"] = require("telescope-undo.actions").restore,
                    },
                },
            },
        },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("env")
    telescope.load_extension("packer")
    telescope.load_extension("http")
    telescope.load_extension("zoxide")
    telescope.load_extension("find_pickers")
    telescope.load_extension('git_diffs')
    telescope.load_extension('undo')
    telescope.load_extension('neoclip')
end
