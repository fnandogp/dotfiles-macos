local actions = require 'telescope.actions'
local telescope = require 'telescope'

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = 'smart_case' -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        }
    }
}

--functions.link_highlight('TelescopeBorder', 'GruvboxBg2', true)
--functions.link_highlight('TelescopePromptBorder', 'GruvboxBg2', true)
--functions.link_highlight('TelescopeResultsBorder', 'GruvboxBg2', true)
--functions.link_highlight('TelescopePreviewBorder', 'GruvboxBg2', true)

--if functions.is_linux() then telescope.load_extension('fzf') end
--telescope.load_extension('mapper')
--telescope.load_extension('projects')
