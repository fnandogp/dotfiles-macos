vim.g.nvim_tree_show_icons = {git = 0, folders = 1, files = 1}

vim.g.nvim_tree_git_hl = 0
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_group_empty = 1

require'nvim-tree'.setup {
    open_on_setup = false,
    open_on_tab = false,
    update_cwd = false,
    auto_close = false,
    follow = 1,
    update_focused_file = {enable = true, update_cwd = false, ignore_list = {}},
    view = {
        -- width of the window, can be either a number (columns) or a string in `%`
        width = 50,
        -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
        side = 'left',
        -- if true the tree will resize itself after opening a file
        auto_resize = false,
        mappings = {
            -- custom only false will merge the list with the default mappings
            -- if true, it will only use your list to set the mappings
            custom_only = false,
            --list = list
        }
    },
    show_icons = {git = false, folders = true, files = true}
}

